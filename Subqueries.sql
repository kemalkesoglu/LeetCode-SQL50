--Employees Whose Manager Left the Company
SELECT employee_id 
FROM Employees
WHERE manager_id NOT IN (SELECT employee_id FROM Employees)
AND salary < 30000
ORDER BY employee_id

--Exchange Seats
SELECT
CASE 
 WHEN id%2=0 THEN id-1
 WHEN id%2=1 AND id+1 NOT IN (SELECT id FROM seat) THEN id
 ELSE id+1
 END AS id,student
FROM Seat
ORDER BY id

--Movie Rating
SELECT*FROM
 (SELECT TOP 1 U.name AS results
FROM MovieRating MR  
LEFT JOIN Users U ON U.user_id = MR.user_id
GROUP BY   MR.user_id, U.name
ORDER BY COUNT(MR.movie_id) DESC, U.name
) N
UNION ALL
SELECT*FROM 
(SELECT TOP 1 M.title AS results
FROM MovieRating MR 
LEFT JOIN Movies M ON M.movie_id = MR.movie_id
WHERE MR.created_at BETWEEN '2020-02-01' AND '2020-02-29' 
ORDER BY AVG(MR.rating*1.0) OVER(PARTITION BY M.title) DESC, M.title ASC
) N2

--Friend Requests II: Who Has the Most Friends
SELECT TOP 1 id, COUNT(*) AS num
    FROM (SELECT requester_id AS id
        FROM RequestAccepted
    UNION ALL
        SELECT accepter_id AS id
        FROM RequestAccepted) SUB
    GROUP BY id
    ORDER BY num DESC
