
# QueueSense – Hidden Waiting-Time & Bottleneck Analytics

## 1. Project Title

**QueueSense – Hidden Waiting-Time & Bottleneck Analytics**

A SQL-based Data Analyst project focused on analyzing e-commerce warehouse operations, order processing times, waiting times, and workflow bottlenecks using MySQL.

## 2. Short Description / Purpose

QueueSense is an e-commerce warehouse analytics project developed to identify operational inefficiencies and hidden waiting times in the order fulfillment process.

The project analyzes order data, warehouse information, product categories, workflow timestamps, and order-related issues to understand processing delays and identify potential bottlenecks.

The main purpose is to transform raw operational data into meaningful insights using SQL queries and key performance indicators (KPIs).

## 3. Tech Stack

- **Database:** MySQL
- **Query Language:** SQL
- **Data Format:** CSV
- **SQL Concepts:** Joins, Common Table Expressions (CTEs), aggregate functions, CASE statements, and date/time functions
- **Data Analysis:** Data cleaning, data quality checks, KPI analysis, and bottleneck detection

## 4. Data Source

The project uses five CSV datasets:

| File Name | Description |
|---|---|
| `orders.csv` | Order IDs, customer IDs, warehouse IDs, order channels, priorities, order timestamps, product categories, and quantities |
| `products.csv` | Product IDs, product names, categories, and unit prices |
| `warehouses.csv` | Warehouse names, cities, and daily order-processing capacities |
| `workflow_events.csv` | Picking, packing, quality control (QC), dispatch, and shipping timestamps |
| `order_issues.csv` | Order issue types and issue durations in minutes |

The SQL scripts define five relational tables: `Orders`, `Products`, `Warehouses`, `WorkflowEvents`, and `OrderIssues`.

## 5. Features / Highlights

- Created a relational database using MySQL.
- Defined tables with primary keys and foreign key relationships.
- Checked duplicate order IDs and missing workflow timestamps.
- Validated workflow timestamp sequences.
- Identified invalid order quantities and negative issue durations.
- Calculated total orders and delivery percentage.
- Analyzed current order backlog.
- Measured average waiting times between workflow stages.
- Identified potential bottlenecks in picking, packing, QC, and dispatch.
- Calculated average total processing time.
- Analyzed delayed orders using issue-duration data.
- Compared processing times across product categories.
- Identified dates and hours with the highest order volume.
- Explored the relationship between order quantity, order volume, and processing time.

## SQL Files

| SQL File | Purpose |
|---|---|
| `tables.sql` | Creates the database and required tables |
| `data clean.sql` | Performs data quality checks |
| `Queries.sql` | Contains SQL queries for operational analysis and KPIs |

## Key Business Questions

1. What is the total number of orders?
2. What percentage of orders have a shipping timestamp?
3. How many orders are currently in the backlog?
4. Which workflow stage has the largest average waiting time?
5. Which stage is the primary processing bottleneck?
6. What is the average total processing time?
7. What is the average picking, QC, and dispatch time?
8. What percentage of orders have a positive issue duration?
9. Which product category takes the longest to process?
10. Which date has the highest order volume?
11. What are the peak order hours?
12. Is order quantity associated with longer processing time?
13. Does peak order volume coincide with longer processing time?

## Repository Structure

```text
QueueSense/
│
├── tables.sql
├── data clean.sql
├── Queries.sql
├── orders.csv
├── products.csv
├── warehouses.csv
├── workflow_events.csv
├── order_issues.csv
└── README.md
```

## Project Outcome

QueueSense demonstrates the practical application of SQL in data analytics, including data validation, relational data analysis, KPI calculations, and warehouse workflow performance analysis.

The project helps identify potential operational bottlenecks and waiting-time patterns, providing a foundation for data-driven decisions and process improvement.

---

**Project Category:** Data Analytics | SQL | E-commerce Operations | Warehouse Analytics
