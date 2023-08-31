create database walmart_que;
use walmart_que;

Create Table Transactions_Walmart (
transaction_id int,
product_id int,
users_id int,
transaction_date date
);
Insert into Transactions_Walmart 
values 
(231574, 111, 234, '2022-03-01'),
(231574, 444, 234, '2022-03-01'),
(231574, 222, 234, '2022-03-01'),
(137124, 444, 125, '2022-03-05'),
(256234, 222, 311, '2022-03-07'),
(523152, 222, 746, '2022-03-06'),
(141415, 333, 235, '2022-03-02'),
(523152, 444, 746, '2022-03-06'),
(137124, 111, 125, '2022-03-05'),
(256234, 333, 311, '2022-03-07');

Create Table Products_Walmart(
product_id int,
product_name varchar(50)
)
;
Insert into Products_Walmart 
values 
(111,'apple'),
(222,'soya milk'),
(333,'instant oatmeal'),
(444,'banana'),
(555,'chia seed');


select * from  Transactions_Walmart;
select * from Products_Walmart;

select concat(upper(substring(product_name,1,1)),lower(substring(product_name,2)))from Products_Walmart;
-- Problem Statement : Write a SQL query to find the top 3 products that are most 
-- frequently bought together (purchased in the same transaction).
-- Output the name of product #1, name of product #2 and number of combinations in descending order.   

WITH cte AS(
SELECT 
    Transaction_id, tw.product_id as productt, pw.product_id as productp, product_name
FROM
    Transactions_Walmart tw
        INNER JOIN
    Products_Walmart pw ON tw.product_id = pw.product_id
      )
SELECT 
    ct.productp,
    ce.productt,
    CONCAT(ct.product_name ,'-', ce.product_name)AS pair, COUNT(1) AS total
FROM
    cte ct
        INNER JOIN
    cte ce ON ct.Transaction_id = ce.Transaction_id
        AND ct.product_name < ce.product_name
GROUP BY ct.product_name , ce.product_name,
          ct.productp, ce.productt
ORDER BY ct.product_name , ce.product_name DESC
;


SELECT 
    tw.product_id as pdt,
    ts.product_id as dd,
    CONCAT(pw.product_name , '-', pt.product_name) AS pair_of_name,
    COUNT(1) as total_pair
FROM
    Transactions_Walmart tw
        INNER JOIN
    Transactions_Walmart ts ON tw.Transaction_id = ts.Transaction_id
        INNER JOIN
    Products_Walmart pw ON pw.product_id = tw.product_id
        INNER JOIN
    Products_Walmart pt ON pt.product_id = ts.product_id
WHERE
    tw.product_id <> ts.product_id
        AND tw.product_id > ts.product_id
GROUP BY tw.product_id , ts.product_id , pw.product_name , pt.product_name

