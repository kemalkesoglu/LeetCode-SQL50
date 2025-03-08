--Number of Unique Subjects Taught by Each Teacher
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt 
FROM Teacher 
GROUP BY teacher_id
ORDER BY teacher_id

--User Activity for the Past 30 Days I
SELECT 
DISTINCT activity_date AS day , 
COUNT(DISTINCT user_id) AS active_users 
FROM Activity 
WHERE Activity_date <= '2019-07-27' AND DATEDIFF(DAY, activity_date,'2019-07-27') <30
GROUP BY activity_date 

--Classes More Than 5 Students
SELECT class FROM Courses
GROUP BY class
HAVING COUNT(DISTINCT student) >=5

--Find Followers Count
SELECT user_id,
COUNT(user_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id

--Customers Who Bought All Products
SELECT customer_id 
FROM Customer C
GROUP BY C.customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product)
