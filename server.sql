
-- create
CREATE TABLE EMPLOYEE (
       WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
       FIRST_NAME CHAR(25),
       LAST_NAME CHAR(25),
       SALARY INT(15),
       JOINING_DATE DATETIME,
       DEPARTMENT CHAR(25)
);

INSERT INTO EMPLOYEE (WORKER_ID,FIRST_NAME,LAST_NAME,SALARY,JOINING_DATE,DEPARTMENT) VALUES 
   (001,'Monika','Arora','100000','14-02-20 09.00.00','HR'),
   (002,'Niharika','Verma','80000','14-06-11 09.00.00','Admin'),
    (003,'Vishal','Singhal','300000','14-02-20 09.00.00','HR'),
   (004,'Amitabh','Singh','500000','14-02-20 09.00.00','HR'), 
   (005,'Vivek','Bhati','500000','14-06-11 09.00.00','ACCOUNT'),
    (006,'Vipul','Diwan','200000','14-06-11 09.00.00','ACCOUNT'),
   (007,'Satish','Kumar','75000','14-01-20 09.00.00','HR'),
    (008,'Geetika','Chauhan','90000','14-05-20 09.00.00','HR');

   

SELECT * FROM EMPLOYEE;
CREATE TABLE BONUS (
       WORKER_REF_ID INT,
       BONUS_AMOUNT INT(10),
       BONUS_DATE DATETIME,
       FOREIGN KEY (WORKER_REF_ID) REFERENCES EMPLOYEE(WORKER_ID) ON DELETE CASCADE
);
INSERT INTO BONUS (WORKER_REF_ID,BONUS_AMOUNT,BONUS_DATE) VALUES 
(001,5000,'16-02-20'),
(002,3000,'16-06-11'),
(003,4000,'16-02-20'),
(001,4500,'16-02-20'),
(002,3500,'16-06-11');
SELECT * FROM BONUS;
CREATE TABLE TITLE (
 WORKER_REF_ID INT,
 WORKER_TITLE CHAR(25),
 AFFECTED_FROM DATETIME,
 FOREIGN KEY (WORKER_REF_ID) REFERENCES EMPLOYEE(WORKER_ID)
 ON DELETE CASCADE

);

INSERT INTO TITLE (WORKER_REF_ID,WORKER_TITLE,AFFECTED_FROM) VALUES 
(001,'MANAGER','16-02-20'),
(002,'EXECUTIVE','16-06-11'),
(008,'EXECUTIVE','16-02-20'),
(005,'MANAGER','16-02-20'),
(004,'ASST. MANAGER','16-06-11'),
(007,'EXECUTIVE','16-02-20'),
(006,'LEAD','16-02-20'),
(003,'LEAD','16-06-11');

SELECT * FROM TITLE;


SELECT UPPER(FIRST_NAME) FROM EMPLOYEE;

SELECT DISTINCT DEPARTMENT FROM EMPLOYEE;

SELECT LOWER(FIRST_NAME) FROM EMPLOYEE;


-- Q: FIRST THREE OCCURANCE OF CHARACTERS IN FIRSTNAME

SELECT SUBSTR(FIRST_NAME,1,3) FROM EMPLOYEE;

-- Q: OCCURANCE POSITION OF B IN AMITABH WORD
SELECT INSTR(FIRST_NAME,'B') FROM EMPLOYEE WHERE FIRST_NAME='Amitabh';

-- Q: PRINT AFTER TRAILING SPACES(RIGHT SIDE) -->RTRIM  FROM LEFT SIDE-->LTRIM
SELECT RTRIM(FIRST_NAME) FROM EMPLOYEE;

-- Q: DISTINCT DEPARTMENT AND PRINT THERI LENGTH
SELECT DISTINCT DEPARTMENT, LENGTH(DEPARTMENT) FROM EMPLOYEE;

-- Q: REPLACE a WITH A IN FIRSTNAME
SELECT REPLACE(FIRST_NAME,'a','A') FROM EMPLOYEE;

-- Q: FIRST_NAME AND LASTNAME--MERGE
SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS NAME FROM EMPLOYEE;

-- Q: FIRST_NAME BY ASCENDING 
SELECT * FROM EMPLOYEE ORDER BY FIRST_NAME ASC;

-- Q: FIRSTNAME ASC AND DEPARTMENT desc
SELECT * FROM EMPLOYEE ORDER BY FIRST_NAME, DEPARTMENT DESC;

-- Q: FIRSTNAME= VIPUL AND Satish
SELECT * FROM EMPLOYEE WHERE FIRST_NAME IN ('VIPUL','SATISH');

-- Q: firstnmae contains 'a'
SELECT * FROM EMPLOYEE WHERE FIRST_NAME LIKE ("%a");

-- Q: ends with h and contains 6 alphabets
SELECT * FROM EMPLOYEE WHERE FIRST_NAME LIKE ("_____h");

-- Q: SALARY LIES BETWEEN 100000 AND 500000
SELECT * FROM EMPLOYEE WHERE SALARY BETWEEN 100000 AND 500000;

-- Q: who joined feb 2014
SELECT * FROM EMPLOYEE WHERE JOINING_DATE BETWEEN "14-02-01" AND "14-02-28";

-- Q: COUNT OF EMPLOYEE WORKING ON PARTICULAR DEPARTMENT
SELECT  DEPARTMENT, COUNT(DEPARTMENT) FROM EMPLOYEE GROUP BY DEPARTMENT;



-- Q: SALARY BOUND BETWEEN 50000 TO 100000 FETCH FULL NAMES 
SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS NAME,SALARY  FROM EMPLOYEE WHERE SALARY BETWEEN 50000 AND 100000;

-- Q: NO OF WORKER IN EACH DEPT IN DESC ORDER
SELECT DEPARTMENT,COUNT(DEPARTMENT) FROM EMPLOYEE GROUP BY DEPARTMENT ORDER BY COUNT(DEPARTMENT) DESC;


-- JOINS
-- Q: WORKERS WHO ARE ALSO MANAGERS 
SELECT e1.FIRST_NAME,e1.LAST_NAME,e2.WORKER_TITLE FROM EMPLOYEE
AS e1 INNER JOIN TITLE AS e2 ON e1.WORKER_ID=e2.WORKER_REF_ID
WHERE e2.WORKER_TITLE="MANAGER";

-- Q: GROUP BY WITH HAVING COUNT >1 IN WORKER TITLE
SELECT WORKER_TITLE,COUNT(WORKER_TITLE) FROM TITLE GROUP BY  WORKER_TITLE HAVING COUNT( WORKER_TITLE)>1 ORDER BY COUNT(WORKER_TITLE) DESC; 

-- Q: SHOW ONLY ODD ROWS--> != SAME AS <>
SELECT * FROM EMPLOYEE WHERE MOD(WORKER_ID,2) <> 0;


-- Q: CLONE A TABLE FROM ANOTHER TABLE 
CREATE TABLE WORKER_CLONE LIKE EMPLOYEE;
INSERT INTO WORKER_CLONE SELECT * FROM EMPLOYEE;

-- Q: FETCH INTERSECTING RECORS
SELECT EMPLOYEE.* FROM EMPLOYEE INNER JOIN WORKER_CLONE USING(WORKER_ID);

-- Q: CURRDATE AND TIME
SELECT CURDATE();
SELECT NOW();

-- Q: NTH HIGHEST SALARY--> LIMIT N-1,1 
SELECT * FROM EMPLOYEE ORDER BY SALARY DESC LIMIT 2,1; 
 
-- IN CORRELATED SUBQUERY
-- SELECT SALARY FROM EMPLOYEE e1 WHERE 3 = (SELECT COUNT(DISTINCT(e2.SALARY))

-- FROM EMPLOYEE e2 where e2.SALARY>=e1.SALARY;

-- );

-- Q: LIST OF SAME SALARY GUY
SELECT * FROM EMPLOYEE e1 INNER JOIN EMPLOYEE e2 ON e2.WORKER_ID!=e1.WORKER_ID WHERE e2.SALARY=e1.SALARY;

-- Q: SECOND HIGHEST SALARY 
 SELECT * FROM EMPLOYEE ORDER BY SALARY DESC LIMIT 2,1;
-- USING SUBQUERY
SELECT MAX(SALARY) FROM EMPLOYEE WHERE SALARY NOT IN (SELECT MAX(SALARY) FROM EMPLOYEE);

-- Q: ONE ROW TWICE IN RESULTS 
-- UNION 

-- Q:SHOW EMPLOYEES WHO DONT GET ANY BONUS
SELECT * FROM EMPLOYEE WHERE WORKER_ID NOT IN (SELECT WORKER_REF_ID FROM BONUS);

-- Q:50% RECORD FROM A TABLE
SELECT * FROM EMPLOYEE WHERE WORKER_ID<=(SELECT COUNT(WORKER_ID)/2 FROM EMPLOYEE);

-- Q: PRINT THOSE DEPARTMENT WHICH HAVE LESS THAN FOOUR EMPLOYEES
SELECT DEPARTMENT,COUNT(DEPARTMENT) FROM EMPLOYEE GROUP BY DEPARTMENT HAVING COUNT(DEPARTMENT)<=4;


-- Q: LAST RECORD FROM TABLE
SELECT * FROM EMPLOYEE WHERE WORKER_ID=(SELECT MAX(WORKER_ID) FROM EMPLOYEE);

-- Q:FIRST RECORD
SELECT * FROM EMPLOYEE WHERE WORKER_ID=(SELECT MIN(WORKER_ID) FROM EMPLOYEE);

-- Q: LAST 5 WORKER 
(SELECT * FROM EMPLOYEE ORDER BY WORKER_ID DESC LIMIT 5) ORDER BY WORKER_ID;

-- Q: NAME OF THE EMPLOYEE FROM EACH DEPARTMENT HAVING HIGHEST SALARY
SELECT e1.* FROM (SELECT MAX(SALARY) AS MAXSAL,DEPARTMENT FROM EMPLOYEE GROUP BY DEPARTMENT) temp
INNER JOIN EMPLOYEE e1 ON temp.DEPARTMENT=e1.DEPARTMENT AND temp.MAXSAL=e1.SALARY;


-- Q: THREE MAX SALARY FROM A TABLE USING CORRELATED
SELECT DISTINCT SALARY FROM EMPLOYEE e1 WHERE 3>=(SELECT COUNT(DISTINCT SALARY) FROM EMPLOYEE e2 WHERE e1.SALARY <= e2.SALARY) ORDER BY e1.SALARY DESC;

-- CAN RGENERALIZE WITH N
-- Q:THREE MINIMUM SALARY USING CORRELATED 
-- SELECT DISTINCT SALARY FROM EMPLOYEE e1 WHERE 3>=(SELECT COUNT(DISTINCT SALARY) FROM EMPLOYEE e2 WHERE e1.SALARY>=e2.SALARY) ORDER BY e1.SALARY;
SELECT SALARY FROM EMPLOYEE ORDER BY SALARY  LIMIT 3;

-- Q:NTH HIGHEST/MINIMUM 

-- Q: DEPARTMENTAL WITH SUM OF SALARIES
SELECT DEPARTMENT,SUM(SALARY) FROM EMPLOYEE GROUP BY DEPARTMENT;

-- Q: NAME OF WORKER HIGHEST SALARY
SELECT * FROM EMPLOYEE WHERE SALARY=(SELECT MAX(SALARY) FROM EMPLOYEE);





//IMPORTTANT QUES :
REMOVED REVERSE PAIRS FROM TABLE 
METHOD:1 LEFT JOIN 
METHOD:2 CORRELATED QUERY

SELECT * FROM TABLE_NAME AS LT LEFT JOIN TABLE_NAME RT ON LT.A=RT.B AND LT.B=RT.a
WHERE RT.A IS NULL OR LT.A<RT.A;


METHOD:2
SELECT FROM TABLE_NAME T1 WHERE NOT EXISTS (SELECT * FROM TABLE_NAME AS T2 T1.B=T2.A AND T1.B=T1.A AND T1.A>T2.A);




Output:ORDER WISE 

+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         1 | Monika     | Arora     | 100000 | 2014-02-20 09:00:00 | HR         |
|         2 | Niharika   | Verma     |  80000 | 2014-06-11 09:00:00 | Admin      |
|         3 | Vishal     | Singhal   | 300000 | 2014-02-20 09:00:00 | HR         |
|         4 | Amitabh    | Singh     | 500000 | 2014-02-20 09:00:00 | HR         |
|         5 | Vivek      | Bhati     | 500000 | 2014-06-11 09:00:00 | ACCOUNT    |
|         6 | Vipul      | Diwan     | 200000 | 2014-06-11 09:00:00 | ACCOUNT    |
|         7 | Satish     | Kumar     |  75000 | 2014-01-20 09:00:00 | HR         |
|         8 | Geetika    | Chauhan   |  90000 | 2014-05-20 09:00:00 | HR         |
+-----------+------------+-----------+--------+---------------------+------------+
+---------------+--------------+---------------------+
| WORKER_REF_ID | BONUS_AMOUNT | BONUS_DATE          |
+---------------+--------------+---------------------+
|             1 |         5000 | 2016-02-20 00:00:00 |
|             2 |         3000 | 2016-06-11 00:00:00 |
|             3 |         4000 | 2016-02-20 00:00:00 |
|             1 |         4500 | 2016-02-20 00:00:00 |
|             2 |         3500 | 2016-06-11 00:00:00 |
+---------------+--------------+---------------------+
+---------------+---------------+---------------------+
| WORKER_REF_ID | WORKER_TITLE  | AFFECTED_FROM       |
+---------------+---------------+---------------------+
|             1 | MANAGER       | 2016-02-20 00:00:00 |
|             2 | EXECUTIVE     | 2016-06-11 00:00:00 |
|             8 | EXECUTIVE     | 2016-02-20 00:00:00 |
|             5 | MANAGER       | 2016-02-20 00:00:00 |
|             4 | ASST. MANAGER | 2016-06-11 00:00:00 |
|             7 | EXECUTIVE     | 2016-02-20 00:00:00 |
|             6 | LEAD          | 2016-02-20 00:00:00 |
|             3 | LEAD          | 2016-06-11 00:00:00 |
+---------------+---------------+---------------------+
+-------------------+
| UPPER(FIRST_NAME) |
+-------------------+
| MONIKA            |
| NIHARIKA          |
| VISHAL            |
| AMITABH           |
| VIVEK             |
| VIPUL             |
| SATISH            |
| GEETIKA           |
+-------------------+
+------------+
| DEPARTMENT |
+------------+
| HR         |
| Admin      |
| ACCOUNT    |
+------------+
+-------------------+
| LOWER(FIRST_NAME) |
+-------------------+
| monika            |
| niharika          |
| vishal            |
| amitabh           |
| vivek             |
| vipul             |
| satish            |
| geetika           |
+-------------------+
+------------------------+
| SUBSTR(FIRST_NAME,1,3) |
+------------------------+
| Mon                    |
| Nih                    |
| Vis                    |
| Ami                    |
| Viv                    |
| Vip                    |
| Sat                    |
| Gee                    |
+------------------------+
+-----------------------+
| INSTR(FIRST_NAME,'B') |
+-----------------------+
|                     6 |
+-----------------------+
+-------------------+
| RTRIM(FIRST_NAME) |
+-------------------+
| Monika            |
| Niharika          |
| Vishal            |
| Amitabh           |
| Vivek             |
| Vipul             |
| Satish            |
| Geetika           |
+-------------------+
+------------+--------------------+
| DEPARTMENT | LENGTH(DEPARTMENT) |
+------------+--------------------+
| HR         |                  2 |
| Admin      |                  5 |
| ACCOUNT    |                  7 |
+------------+--------------------+
+-----------------------------+
| REPLACE(FIRST_NAME,'a','A') |
+-----------------------------+
| MonikA                      |
| NihArikA                    |
| VishAl                      |
| AmitAbh                     |
| Vivek                       |
| Vipul                       |
| SAtish                      |
| GeetikA                     |
+-----------------------------+
+-----------------+
| NAME            |
+-----------------+
| Monika Arora    |
| Niharika Verma  |
| Vishal Singhal  |
| Amitabh Singh   |
| Vivek Bhati     |
| Vipul Diwan     |
| Satish Kumar    |
| Geetika Chauhan |
+-----------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         4 | Amitabh    | Singh     | 500000 | 2014-02-20 09:00:00 | HR         |
|         8 | Geetika    | Chauhan   |  90000 | 2014-05-20 09:00:00 | HR         |
|         1 | Monika     | Arora     | 100000 | 2014-02-20 09:00:00 | HR         |
|         2 | Niharika   | Verma     |  80000 | 2014-06-11 09:00:00 | Admin      |
|         7 | Satish     | Kumar     |  75000 | 2014-01-20 09:00:00 | HR         |
|         6 | Vipul      | Diwan     | 200000 | 2014-06-11 09:00:00 | ACCOUNT    |
|         3 | Vishal     | Singhal   | 300000 | 2014-02-20 09:00:00 | HR         |
|         5 | Vivek      | Bhati     | 500000 | 2014-06-11 09:00:00 | ACCOUNT    |
+-----------+------------+-----------+--------+---------------------+------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         4 | Amitabh    | Singh     | 500000 | 2014-02-20 09:00:00 | HR         |
|         8 | Geetika    | Chauhan   |  90000 | 2014-05-20 09:00:00 | HR         |
|         1 | Monika     | Arora     | 100000 | 2014-02-20 09:00:00 | HR         |
|         2 | Niharika   | Verma     |  80000 | 2014-06-11 09:00:00 | Admin      |
|         7 | Satish     | Kumar     |  75000 | 2014-01-20 09:00:00 | HR         |
|         6 | Vipul      | Diwan     | 200000 | 2014-06-11 09:00:00 | ACCOUNT    |
|         3 | Vishal     | Singhal   | 300000 | 2014-02-20 09:00:00 | HR         |
|         5 | Vivek      | Bhati     | 500000 | 2014-06-11 09:00:00 | ACCOUNT    |
+-----------+------------+-----------+--------+---------------------+------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         6 | Vipul      | Diwan     | 200000 | 2014-06-11 09:00:00 | ACCOUNT    |
|         7 | Satish     | Kumar     |  75000 | 2014-01-20 09:00:00 | HR         |
+-----------+------------+-----------+--------+---------------------+------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         1 | Monika     | Arora     | 100000 | 2014-02-20 09:00:00 | HR         |
|         2 | Niharika   | Verma     |  80000 | 2014-06-11 09:00:00 | Admin      |
|         8 | Geetika    | Chauhan   |  90000 | 2014-05-20 09:00:00 | HR         |
+-----------+------------+-----------+--------+---------------------+------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         7 | Satish     | Kumar     |  75000 | 2014-01-20 09:00:00 | HR         |
+-----------+------------+-----------+--------+---------------------+------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         1 | Monika     | Arora     | 100000 | 2014-02-20 09:00:00 | HR         |
|         3 | Vishal     | Singhal   | 300000 | 2014-02-20 09:00:00 | HR         |
|         4 | Amitabh    | Singh     | 500000 | 2014-02-20 09:00:00 | HR         |
|         5 | Vivek      | Bhati     | 500000 | 2014-06-11 09:00:00 | ACCOUNT    |
|         6 | Vipul      | Diwan     | 200000 | 2014-06-11 09:00:00 | ACCOUNT    |
+-----------+------------+-----------+--------+---------------------+------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         1 | Monika     | Arora     | 100000 | 2014-02-20 09:00:00 | HR         |
|         3 | Vishal     | Singhal   | 300000 | 2014-02-20 09:00:00 | HR         |
|         4 | Amitabh    | Singh     | 500000 | 2014-02-20 09:00:00 | HR         |
+-----------+------------+-----------+--------+---------------------+------------+
+------------+-------------------+
| DEPARTMENT | COUNT(DEPARTMENT) |
+------------+-------------------+
| HR         |                 5 |
| Admin      |                 1 |
| ACCOUNT    |                 2 |
+------------+-------------------+
+-----------------+--------+
| NAME            | SALARY |
+-----------------+--------+
| Monika Arora    | 100000 |
| Niharika Verma  |  80000 |
| Satish Kumar    |  75000 |
| Geetika Chauhan |  90000 |
+-----------------+--------+
+------------+-------------------+
| DEPARTMENT | COUNT(DEPARTMENT) |
+------------+-------------------+
| HR         |                 5 |
| ACCOUNT    |                 2 |
| Admin      |                 1 |
+------------+-------------------+
+------------+-----------+--------------+
| FIRST_NAME | LAST_NAME | WORKER_TITLE |
+------------+-----------+--------------+
| Monika     | Arora     | MANAGER      |
| Vivek      | Bhati     | MANAGER      |
+------------+-----------+--------------+
+--------------+---------------------+
| WORKER_TITLE | COUNT(WORKER_TITLE) |
+--------------+---------------------+
| EXECUTIVE    |                   3 |
| MANAGER      |                   2 |
| LEAD         |                   2 |
+--------------+---------------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         1 | Monika     | Arora     | 100000 | 2014-02-20 09:00:00 | HR         |
|         3 | Vishal     | Singhal   | 300000 | 2014-02-20 09:00:00 | HR         |
|         5 | Vivek      | Bhati     | 500000 | 2014-06-11 09:00:00 | ACCOUNT    |
|         7 | Satish     | Kumar     |  75000 | 2014-01-20 09:00:00 | HR         |
+-----------+------------+-----------+--------+---------------------+------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         1 | Monika     | Arora     | 100000 | 2014-02-20 09:00:00 | HR         |
|         2 | Niharika   | Verma     |  80000 | 2014-06-11 09:00:00 | Admin      |
|         3 | Vishal     | Singhal   | 300000 | 2014-02-20 09:00:00 | HR         |
|         4 | Amitabh    | Singh     | 500000 | 2014-02-20 09:00:00 | HR         |
|         5 | Vivek      | Bhati     | 500000 | 2014-06-11 09:00:00 | ACCOUNT    |
|         6 | Vipul      | Diwan     | 200000 | 2014-06-11 09:00:00 | ACCOUNT    |
|         7 | Satish     | Kumar     |  75000 | 2014-01-20 09:00:00 | HR         |
|         8 | Geetika    | Chauhan   |  90000 | 2014-05-20 09:00:00 | HR         |
+-----------+------------+-----------+--------+---------------------+------------+
+------------+
| CURDATE()  |
+------------+
| 2024-08-05 |
+------------+
+---------------------+
| NOW()               |
+---------------------+
| 2024-08-05 17:34:03 |
+---------------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         3 | Vishal     | Singhal   | 300000 | 2014-02-20 09:00:00 | HR         |
+-----------+------------+-----------+--------+---------------------+------------+
+-----------+------------+-----------+--------+---------------------+------------+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT | WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+-----------+------------+-----------+--------+---------------------+------------+
|         5 | Vivek      | Bhati     | 500000 | 2014-06-11 09:00:00 | ACCOUNT    |         4 | Amitabh    | Singh     | 500000 | 2014-02-20 09:00:00 | HR         |
|         4 | Amitabh    | Singh     | 500000 | 2014-02-20 09:00:00 | HR         |         5 | Vivek      | Bhati     | 500000 | 2014-06-11 09:00:00 | ACCOUNT    |
+-----------+------------+-----------+--------+---------------------+------------+-----------+------------+-----------+--------+---------------------+------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         3 | Vishal     | Singhal   | 300000 | 2014-02-20 09:00:00 | HR         |
+-----------+------------+-----------+--------+---------------------+------------+
+-------------+
| MAX(SALARY) |
+-------------+
|      300000 |
+-------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         4 | Amitabh    | Singh     | 500000 | 2014-02-20 09:00:00 | HR         |
|         5 | Vivek      | Bhati     | 500000 | 2014-06-11 09:00:00 | ACCOUNT    |
|         6 | Vipul      | Diwan     | 200000 | 2014-06-11 09:00:00 | ACCOUNT    |
|         7 | Satish     | Kumar     |  75000 | 2014-01-20 09:00:00 | HR         |
|         8 | Geetika    | Chauhan   |  90000 | 2014-05-20 09:00:00 | HR         |
+-----------+------------+-----------+--------+---------------------+------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         1 | Monika     | Arora     | 100000 | 2014-02-20 09:00:00 | HR         |
|         2 | Niharika   | Verma     |  80000 | 2014-06-11 09:00:00 | Admin      |
|         3 | Vishal     | Singhal   | 300000 | 2014-02-20 09:00:00 | HR         |
|         4 | Amitabh    | Singh     | 500000 | 2014-02-20 09:00:00 | HR         |
+-----------+------------+-----------+--------+---------------------+------------+
+------------+-------------------+
| DEPARTMENT | COUNT(DEPARTMENT) |
+------------+-------------------+
| Admin      |                 1 |
| ACCOUNT    |                 2 |
+------------+-------------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         8 | Geetika    | Chauhan   |  90000 | 2014-05-20 09:00:00 | HR         |
+-----------+------------+-----------+--------+---------------------+------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         1 | Monika     | Arora     | 100000 | 2014-02-20 09:00:00 | HR         |
+-----------+------------+-----------+--------+---------------------+------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         4 | Amitabh    | Singh     | 500000 | 2014-02-20 09:00:00 | HR         |
|         5 | Vivek      | Bhati     | 500000 | 2014-06-11 09:00:00 | ACCOUNT    |
|         6 | Vipul      | Diwan     | 200000 | 2014-06-11 09:00:00 | ACCOUNT    |
|         7 | Satish     | Kumar     |  75000 | 2014-01-20 09:00:00 | HR         |
|         8 | Geetika    | Chauhan   |  90000 | 2014-05-20 09:00:00 | HR         |
+-----------+------------+-----------+--------+---------------------+------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         2 | Niharika   | Verma     |  80000 | 2014-06-11 09:00:00 | Admin      |
|         4 | Amitabh    | Singh     | 500000 | 2014-02-20 09:00:00 | HR         |
|         5 | Vivek      | Bhati     | 500000 | 2014-06-11 09:00:00 | ACCOUNT    |
+-----------+------------+-----------+--------+---------------------+------------+
+--------+
| SALARY |
+--------+
| 500000 |
| 300000 |
| 200000 |
+--------+
+--------+
| SALARY |
+--------+
|  75000 |
|  80000 |
|  90000 |
+--------+
+------------+-------------+
| DEPARTMENT | SUM(SALARY) |
+------------+-------------+
| HR         |     1065000 |
| Admin      |       80000 |
| ACCOUNT    |      700000 |
+------------+-------------+
+-----------+------------+-----------+--------+---------------------+------------+
| WORKER_ID | FIRST_NAME | LAST_NAME | SALARY | JOINING_DATE        | DEPARTMENT |
+-----------+------------+-----------+--------+---------------------+------------+
|         4 | Amitabh    | Singh     | 500000 | 2014-02-20 09:00:00 | HR         |
|         5 | Vivek      | Bhati     | 500000 | 2014-06-11 09:00:00 | ACCOUNT    |
+-----------+------------+-----------+--------+---------------------+------------+