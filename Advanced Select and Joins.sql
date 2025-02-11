--The Number of Employees Which Report to Each Employee--
SELECT 
    E1.employee_id, 
    E1.name, 
    COUNT(E2.reports_to) AS reports_count, 
    ROUND(avg(E2.age * 1.00), 0) AS average_age 
FROM Employees E1 
LEFT JOIN Employees E2 ON E1.employee_id = E2.reports_to 
WHERE E2.reports_to IS NOT NULL
GROUP BY E1.employee_id, E1.name, E2.reports_to
ORDER BY E1.employee_id

--Primary Department for Each Employee--
SELECT employee_id,department_id FROM Employee
WHERE primary_flag='Y' OR employee_id IN
(
    SELECT employee_id FROM Employee 
    GROUP BY employee_id
    HAVING COUNT(department_id)=1
)

--Triangle Judgement--
SELECT x,y,z,
CASE WHEN x+y>z AND x+z>y AND y+z>x THEN 'Yes'
ELSE 'No' END AS triangle
FROM Triangle

