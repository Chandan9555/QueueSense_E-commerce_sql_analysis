USE queuesensedb;


-- 1. Check duplicates
SELECT order_id, COUNT(*) AS duplicate_count
FROM Orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- 2. Check missing critical timestamps
SELECT * 
FROM WorkflowEvents
WHERE pick_start IS NULL
	OR pick_end IS NULL 
    OR pack_start IS NULL
    OR pack_end IS NULL
    OR qc_start IS NULL
    OR qc_end IS NULL
    OR dispatch_start IS NULL
    OR dispatch_end IS NULL;
    
    
-- 3. Check invalid workflow sequence
SELECT * 
FROM WorkflowEvents
WHERE pick_end < pick_start
   OR pack_start < pick_end
   OR pack_end < pack_start
   OR qc_start < pack_end
   OR qc_end < qc_start
   OR dispatch_start < qc_end
   OR dispatch_end < dispatch_start
   OR ship_time < dispatch_end;
   

-- 4. Check invalid quantities
SELECT *
FROM Orders
WHERE quantity <=0;


-- 5. Check invalid issue minutes
SELECT * 
FROM OrderIssues
WHERE issue_minutes < 0;



