--Replace Employee ID With The Unique Identifier
SELECT unique_id,name 
FROM Employees E
LEFT JOIN EmployeeUNI EU
ON E.id=EU.id

 
 --Product Sales Analysis I
SELECT product_name,year,price 
FROM Sales S
JOIN Product P ON S.product_id=P.product_id
 

--Customer Who Visited but Did Not Make Any Transactions
SELECT customer_id,COUNT(*) AS count_no_trans
FROM Visits V
LEFT JOIN Transactions T 
ON T.visit_id=V.visit_id
WHERE T.transaction_id IS NULL
GROUP BY customer_id
ORDER BY count_no_trans

 
--Rising Temperature
SELECT W2.id
FROM Weather W1
INNER JOIN Weather W2
ON  DATEDIFF(DAY,W1.recordDate,W2.recordDate)=1
WHERE W2.temperature > W1.temperature 
 

--Average Time of Process per Machine
SELECT A1.machine_id, 
 ROUND(AVG(A2.timestamp - A1.timestamp),3) AS processing_time
FROM Activity A1
JOIN Activity A2
ON A1.process_id = A2.process_id
AND A1.machine_id = A2.machine_id
AND A1.timestamp < A2.timestamp
GROUP BY A1.machine_id

 
--Employee Bonus
SELECT E.name,B.bonus
FROM Employee E
LEFT JOIN Bonus B ON E.empId=B.empId
WHERE B.bonus<1000 OR B.bonus IS NULL

 
 --Students and Examinations
 SELECT ST.student_id, student_name,S.subject_name, 
COUNT(E.subject_name) AS attended_exams
FROM STUDENTS ST
CROSS JOIN SUBJECTS S
LEFT JOIN EXAMINATIONS E
ON E.student_id = ST.student_id AND S.subject_name = E.subject_name
GROUP BY ST.student_id,student_name,S.subject_name
ORDER BY ST.student_id,S.subject_name


--Managers with at Least 5 Direct Reports
SELECT name 
FROM Employee 
WHERE  id IN 
(SELECT managerId FROM Employee 
GROUP BY managerId 
HAVING COUNT(managerId)>=5)
 
 
--Confirmation Rate
SELECT S.user_id,
CASE WHEN C.user_id is NULL THEN 0
ELSE
ROUND(SUM(CASE WHEN action='confirmed' THEN 1 ELSE 0 END)/CAST(COUNT(C.user_id) AS FLOAT),2) 
END AS confirmation_rate
FROM Signups S
LEFT JOIN Confirmations C  ON S.user_id=C.user_id
GROUP BY S.user_id,C.user_id
