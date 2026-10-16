CREATE DATABASE QueueSenseDB;

USE QueueSenseDB;

-- Creating a table Warehouse.
CREATE TABLE Warehouses(
	warehouse_id VARCHAR(20) PRIMARY KEY,
    warehouse_name VARCHAR(100),
    city VARCHAR(50),
    capacity_orders_per_day int
);


-- Creating a table Products.
CREATE TABLE Products(
	product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(12,2)
);


-- Creating a table Orders.
CREATE TABLE Orders(
	order_id BIGINT PRIMARY KEY,
    customer_id INT,
    warehouse_id VARCHAR(20),
    channel VARCHAR(30),
    priority VARCHAR(20),
    order_time DATETIME,
    product_category VARCHAR(50),
    quantity INT,
    CONSTRAINT FK_Orders_Warehouse
    FOREIGN KEY (warehouse_id)
    REFERENCES Warehouses(warehouse_id)
);


-- Creating a table workflowevents.
CREATE TABLE WorkflowEvents(
	order_id BIGINT PRIMARY KEY,
    pick_start DATETIME,
    pick_end DATETIME,
    pack_start DATETIME,
    pack_end DATETIME,
    qc_start DATETIME,
    qc_end DATETIME,
    dispatch_start DATETIME,
    dispatch_end DATETIME,
    ship_time DATETIME,
    picker_id VARCHAR(20),
    packer_id VARCHAR(20),
	CONSTRAINT FK_Workflow_Order 
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id)
);


-- Creating a table OrderIssues.
CREATE TABLE OrderIssues(
	order_id BIGINT PRIMARY KEY,
	issue_type VARCHAR(50),
	issue_minutes INT,
	CONSTRAINT FK_Issue_Order
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id)
);





