-- Analysis Questions

USE queuesensedb;

-- 1. Total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;


-- 2. Percentage of orders successfully delivered 
SELECT 
	ROUND(
		100.0 * SUM(CASE WHEN ship_time IS NOT NULL THEN 1 ELSE 0 END)/COUNT(*),2)
        AS delivered_percentage
	FROM workflowEvents;


-- 3. Current order backlog
SELECT COUNT(*) AS current_backlog
FROM workflowevents
WHERE ship_time IS NULL;


-- 4. Stage with largest queue
SELECT 
	ROUND(AVG(TIMESTAMPDIFF(MINUTE, pick_end, pack_start)), 2) AS avg_packing_queue,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, pack_end, qc_start)), 2) AS avg_qc_queue,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, qc_end, dispatch_start)), 2) AS avg_dispatch_queue
FROM workflowevents;


-- 5. Which stage is the primary bottleneck ?
WITH stage_times AS (
	SELECT 
		AVG(TIMESTAMPDIFF(MINUTE, pick_start, pick_end)) AS picking_time,
        AVG(TIMESTAMPDIFF(MINUTE, pack_start, pack_end)) AS packing_time,
        AVG(TIMESTAMPDIFF(MINUTE, qc_start, qc_end)) AS qc_time,
        AVG(TIMESTAMPDIFF(MINUTE, dispatch_start, dispatch_end)) AS dispatch_time
	FROM workflowevents
)
 SELECT     
	CASE 
		WHEN picking_time >= packing_time
			AND picking_time >= qc_time
			AND picking_time >= dispatch_time
			THEN 'Picking'
		WHEN packing_time >= picking_time
			AND packing_time >= qc_time
            AND packing_time >= dispatch_time
            THEN 'Packing'
		WHEN qc_time >= picking_time
			AND qc_time >= packing_time
            AND qc_time >= dispatch_time
            THEN 'QC'
		ELSE 'Dispatch'
	END AS primary_bottleneck
FROM stage_times;
        
		
-- 6. Average total processing time
SELECT 
	ROUND(
		AVG(
			TIMESTAMPDIFF(
				MINUTE,
                pick_start,
                dispatch_end
			)
		),
        2
	) AS avg_total_processing_minutes
FROM workflowevents;


-- 7. Average picking time 
SELECT
	ROUND(
		AVG(
			TIMESTAMPDIFF(
				MINUTE,
                pick_start,
                pick_end
			)
		),
        2
	) AS avg_picking__minutes
FROM workflowevents;


-- 8. Average QC time
SELECT 
	ROUND(
		AVG(
			TIMESTAMPDIFF(
				MINUTE,
                qc_start,
                qc_end
			)
		),
        2
	) AS avg_qc_minutes
FROM workflowevents;


-- 9. Average dispatch time 
SELECT 
	ROUND(
		AVG(
			TIMESTAMPDIFF(
				MINUTE,
                dispatch_start,
                dispatch_end
			)
		),
        2
	) AS avg_dispatch_minutes
FROM workflowevents;


-- 10. Percentage of orders are delayed
SELECT 
	ROUND(
		100.0 * SUM(
			CASE 
				WHEN issue_minutes > 0 THEN 1
                ELSE 0
			END
		) / COUNT(*), 
        2
	) AS delayed_order_percentage
FROM orderissues;


-- 11. Which product category takes the longest to process ?
SELECT 
	o.product_category,
    COUNT(*) AS total_orders,
    ROUND(
		AVG(
			TIMESTAMPDIFF(
				MINUTE,
                wfe.pick_start,
                wfe.dispatch_end
			)
		),
        2
	) AS avg_processing_minutes
FROM orders o 
JOIN workflowevents wfe
	ON o.order_id = wfe.order_id
GROUP BY o.product_category
ORDER  BY avg_processing_minutes DESC;


-- 12. Which day has the highest order volume ?
SELECT  
	DATE(order_time) AS order_date,
    COUNT(*) AS order_volume
FROM orders
GROUP BY DATE(order_time)
ORDER BY order_volume DESC
LIMIT 1;


-- 13. What are the peak order hour ?
SELECT 
	HOUR(order_time) AS order_hour,
    COUNT(*) AS order_volume
FROM orders
GROUP BY HOUR(order_time)
ORDER BY order_volume DESC
LIMIT 5;


-- 14. Is order quantity associated with longer processing time
SELECT 
	o.quantity,
    COUNT(*) AS total_orders,
    ROUND(
		AVG(
			TIMESTAMPDIFF(
				MINUTE,
                w.pick_start,
                w.dispatch_end
			)
		),
        2
	) AS avg_processing_minutes
FROM orders o
JOIN workflowevents w
	ON o.order_id = w.order_id
WHERE w.pick_start IS NOT NULL
	AND w.dispatch_end IS NOT NULL
GROUP BY o.quantity
ORDER BY o.quantity;


-- 15. Does peak order volume increase processing time ?
With hourly_analysis AS (
	SELECT 
		HOUR(o.order_time) AS order_hour,
        COUNT(*) AS order_volume, 
        ROUND(
			AVG(
				TIMESTAMPDIFF(
					MINUTE,
                    wfe.pick_start,
                    wfe.dispatch_end
				)
			),
            2
		)AS avg_processing_minutes
	FROM orders o
    JOIN workflowevents wfe 
		ON o.order_id = wfe.order_id
	GROUP BY HOUR(o.order_time)
)
SELECT * 
FROM hourly_analysis
ORDER BY order_volume DESC;