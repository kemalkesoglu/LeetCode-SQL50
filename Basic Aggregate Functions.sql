--Not Boring Movies
SELECT*FROM Cinema
WHERE id%2=1 AND description NOT LIKE '%boring%'
ORDER BY rating DESC

--Average Selling Price
WITH AVP AS(
    SELECT P.product_id, P.price, U.units
    FROM Prices P 
    LEFT JOIN UnitsSold U
    ON P.product_id = U.product_id
    AND purchase_date >= start_date and purchase_date <= end_date
)
SELECT product_id, COALESCE(ROUND(CAST(SUM(units * price) AS FLOAT) / SUM(units),2),0) AS average_price
FROM AVP
GROUP BY product_id

--Project Employees I
SELECT 
P.project_id, ROUND(AVG(E.experience_years*1.0),2) AS average_years
FROM Project P
JOIN Employee E 
ON P.employee_id=E.employee_id
GROUP BY P.project_id

--Percentage of Users Attended a Contest
SELECT
contest_id,
ROUND(COUNT(user_id)*100.0/(SELECT COUNT(DISTINCT user_id) FROM Users), 2) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC,contest_id

--Monthly Transactions I
SELECT 
     FORMAT(trans_date, 'yyyy-MM') AS month,
     country,
     COUNT(*) AS trans_count,
     SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
     SUM(amount) AS trans_total_amount,
     SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY FORMAT(trans_date,'yyyy-MM'),country
