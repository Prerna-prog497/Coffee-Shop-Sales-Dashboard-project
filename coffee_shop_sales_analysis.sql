CREATE DATABASE coffee_shop_project;
USE coffee_shop_project;

CREATE TABLE coffee_shop_sales (
transaction_id INT,
transaction_date VARCHAR(20),
transaction_time VARCHAR(20),
store_location VARCHAR(50),
product_category VARCHAR(50),
product_type VARCHAR(50),
product_detail VARCHAR(100),
transaction_qty INT,
unit_price FLOAT
);coffee_shop_sales

DROP TABLE coffee_shop_sales;

CREATE TABLE coffee_shop_sales (
transaction_id INT,
transaction_date VARCHAR(20),
transaction_time VARCHAR(20),
transaction_qty INT,
store_id INT,
store_location VARCHAR(50),
product_id INT,
unit_price FLOAT,
product_category VARCHAR(50),
product_type VARCHAR(50),
product_detail VARCHAR(100)
);

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/User-HP/OneDrive/Desktop/Coffee Shop Sales.csv'
INTO TABLE coffee_shop_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM coffee_shop_sales LIMIT 10;

SELECT ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5;

SELECT COUNT(transaction_id) AS Total_Orders
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5;

SELECT SUM(transaction_qty) AS Total_Quantity_Sold
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5;

SELECT store_location,
SUM(unit_price * transaction_qty) AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY store_location
ORDER BY Total_Sales DESC;

SELECT product_type,
SUM(unit_price * transaction_qty) AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY product_type
ORDER BY Total_Sales DESC
LIMIT 10;

SELECT DAYNAME(transaction_date) AS Day_of_Week,
SUM(unit_price * transaction_qty) AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY Day_of_Week;

SELECT HOUR(transaction_time) AS Hour_of_Day,
SUM(unit_price * transaction_qty) AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY Hour_of_Day
ORDER BY Hour_of_Day;

SET SQL_SAFE_UPDATES = 0;

UPDATE coffee_shop_sales
SET transaction_date = STR_TO_DATE(transaction_date,'%d-%m-%Y');

ALTER TABLE coffee_shop_sales
MODIFY COLUMN transaction_date DATE;

UPDATE coffee_shop_sales
SET transaction_time = STR_TO_DATE(transaction_time,'%H:%i:%s');

ALTER TABLE coffee_shop_sales
MODIFY COLUMN transaction_time TIME;

SELECT store_location,
SUM(unit_price * transaction_qty) AS Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY store_location
ORDER BY Total_Sales DESC;