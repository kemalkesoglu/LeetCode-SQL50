--Fix Names in a Table
SELECT user_id,
CONCAT(UPPER(SUBSTRING(name,1,1)),LOWER(SUBSTRING(name,2,10))) AS name 
FROM Users
ORDER BY user_id

--Delete Duplicate Emails
DELETE P1 FROM PERSON P1, PERSON P2
WHERE P1.Email = P2.Email AND P1.Id>P2.Id 

--Second Highest Salary
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee 
WHERE salary <> (SELECT MAX(salary) FROM Employee)

--Group Sold Products By The Date
WITH CTE AS(
    SELECT DISTINCT sell_date,product FROM Activities
),

CTE2 AS(
    SELECT sell_date,COUNT(product) AS num_sold 
FROM CTE 
GROUP BY sell_date
)

SELECT
sell_date,num_sold,
(SELECT STRING_AGG(product,',') FROM CTE C 
WHERE C.sell_date=C2.sell_date) AS products
FROM CTE2 C2
