
select * from Studies
select * from Software
select * from Programmer

--53. Which Female Programmer earning more than 3000 does not know C, C++, ORACLE or DBASE? 
SELECT * FROM PROGRAMMER WHERE GENDER = 'F' AND SALARY >3000 AND 
prof1<>'c' and prof1<>'c++' and prof1<>'oracle'and prof1<>'dbase' and prof2<>'c' and prof2<>'c++' and prof2<>'oracle' and prof2<>'dbase' ;

---54. Which Institute has most number of Students? 
CREATE TABLE InstStudNo (InstituteName VARCHAR(20), StdNo INT)

INSERT INTO InstStudNo
SELECT INSTITUTE,COUNT(PNAME) FROM studies GROUP BY INSTITUTE

SELECT InstituteName,StdNo AS COUNT_OF_STUDENTS FROM InstStudNo
WHERE StdNo = (SELECT MAX(StdNo) FROM InstStudNo)

select * from InstStudNo

--55. What is the Costliest course? 
SELECT COURSE_fee
FROM STUDIES
WHERE course_fee = (SELECT MAX(course_fee) FROM STUDIES);

--56. Which course has been done by the most of the Students? 
CREATE TABLE CourStudNo (CourNam VARCHAR(20), StdNo INT)

INSERT INTO CourStudNo
SELECT COURSE,COUNT(PNAME) FROM studies GROUP BY COURSE

select * from CourStudNo

SELECT CourNam,StdNo AS COUNT_OF_STUDENTS FROM CourStudNo WHERE StdNo = 
(SELECT MAX(StdNo) FROM CourStudNo)


--57. Which Institute conducts costliest course. 
SELECT institute, COURSE FROM STUDIES WHERE COURSE_FEE = (SELECT MAX(course_fee) FROM STUDIES);

--58. Display the name of the Institute and Course, which has below AVG course fee.
select institute, course from studies where course_fee  < (SELECT AVG(course_fee) FROM STUDIES);

--59. Display the names of the courses whose fees are within 1000 (+ or -) of the Average Fee, 
SELECT COURSE FROM STUDIES WHERE course_fee < (SELECT AVG(course_fee)+1000 FROM STUDIES) AND course_fee > (SELECT AVG(course_fee)-1000 FROM STUDIES);

--60. Which package has the Highest Development cost? 
SELECT TITLE,DCOST FROM SOFTWARE WHERE DCOST = (SELECT MAX(DCOST) FROM SOFTWARE);

--61. Which course has below AVG number of Students? 
CREATE TABLE AVGCNT (CRS VARCHAR(20), CNT INT)

INSERT INTO AVGCNT
SELECT COURSE, COUNT(PNAME) FROM studies GROUP BY COURSE
SELECT CRS,CNT FROM AVGCNT WHERE CNT <=(SELECT AVG(CNT) FROM AVGCNT)

--62. Which Package has the lowest selling cost? 
SELECT TITLE,SCOST FROM SOFTWARE WHERE SCOST = (SELECT MIN(SCOST) FROM SOFTWARE);

--63. Who Developed the Package that has sold the least number of copies? 
SELECT PNAME,SOLD FROM SOFTWARE WHERE SOLD = (SELECT MIN(SOLD) FROM SOFTWARE);

--64. Which language has used to develop the package, which has the highest sales amount? 
SELECT DEVELOPIN,SCOST FROM SOFTWARE WHERE SCOST = (SELECT MAX(SCOST) FROM SOFTWARE);

--65. How many copies of package that has the least difference between development and selling cost where sold. 
SELECT SOLD,TITLE FROM SOFTWARE 
WHERE TITLE = (SELECT TITLE FROM SOFTWARE
WHERE (DCOST-SCOST)=(SELECT MIN(DCOST-SCOST) FROM SOFTWARE));

--66. Which is the costliest package developed in PASCAL. 
SELECT TITLE FROM SOFTWARE WHERE DCOST = (SELECT MAX(DCOST)FROM SOFTWARE WHERE DEVELOPIN LIKE 'PASCAL');

--67. Which language was used to develop the most number of Packages. 
SELECT DEVELOPIN FROM SOFTWARE GROUP BY DEVELOPIN  HAVING DEVELOPIN = (SELECT MAX(DEVELOPIN) FROM SOFTWARE);

--68. Which programmer has developed the highest number of Packages
SELECT PNAME FROM SOFTWARE GROUP BY PNAME HAVING PNAME = (SELECT MAX(PNAME) FROM SOFTWARE);

--69. Who is the Author of the Costliest Package? 
 SELECT PNAME, DCOST FROM SOFTWARE WHERE DCOST = (SELECT MAX(DCOST) FROM SOFTWARE);

--70. Display the names of the packages, which have sold less than the AVG number of copies. 
SELECT TITLE FROM SOFTWARE WHERE SOLD < (SELECT AVG(SOLD) FROM SOFTWARE);

--71. Who are the authors of the Packages, which have recovered more than double the Development cost? 
SELECT  distinct PNAME FROM SOFTWARE WHERE SOLD*SCOST > 2*DCOST;

--72. Display the programmer Name and the cheapest packages developed by them in each language. 
SELECT PNAME,TITLE FROM SOFTWARE WHERE DCOST IN (SELECT MIN(DCOST) FROM SOFTWARE GROUP BY DEVELOPIN);

--73. Display the language used by each programmer to develop the Highest Selling and Lowest-selling package. 
SELECT PNAME, DEVELOPIN FROM SOFTWARE WHERE SOLD IN (SELECT MAX(SOLD) FROM SOFTWARE GROUP BY PNAME)
UNION
SELECT PNAME, DEVELOPIN FROM SOFTWARE WHERE SOLD IN (SELECT MIN(SOLD) FROM SOFTWARE GROUP BY PNAME);

--74. Who is the youngest male Programmer born in 1965? 
SELECT pname, 
case
when dateadd(year, datediff(YEAR, dob, getdate()), dob)>getdate()
then datediff(YEAR, dob, getdate()) - 1
else
datediff(YEAR, dob, getdate()) end As Age
from programmer where dob = (SELECT max(dob) from programmer where YEAR(dob)='1965' and GENDER='M');


--75. Who is the oldest Female Programmer who joined in 1992?
SELECT pname, 
case
when dateadd(year, datediff(YEAR, dob, getdate()), dob)>getdate()
then datediff(YEAR, dob, getdate()) - 1
else
datediff(YEAR, dob, getdate()) end As Age
from programmer where dob = (SELECT min(dob) from programmer where YEAR(doj)='1992' and GENDER='F');

--76. In which year was the most number of Programmers born. 
CREATE TABLE TEMP (YOB INT, CNT INT)

INSERT INTO TEMP
SELECT YEAR(DOB) AS YEAR ,COUNT(pname) FROM programmer GROUP BY YEAR(DOB)

SELECT * FROM TEMP

SELECT YOB, CNT FROM TEMP WHERE CNT= (SELECT MAX(CNT) FROM TEMP)

--77. In which month did most number of programmers join? 
CREATE TABLE MOJ (MOJ INT, CNT INT)

INSERT INTO MOJ
SELECT MONTH(DOJ),COUNT(pname) FROM programmer GROUP BY MONTH(DOJ)

SELECT MOJ, CNT FROM MOJ WHERE CNT= (SELECT MAX(CNT) FROM MOJ)


--78. In which language are most of the programmer’s proficient. 
CREATE TABLE PCNT (PR VARCHAR(20), CNT INT)
CREATE TABLE PsCNT (PRs VARCHAR(20), sCNT INT)

INSERT INTO PCNT
SELECT PROF1, COUNT(pname) FROM programmer GROUP BY PROF1 UNION ALL
SELECT PROF2, COUNT(pname) FROM programmer GROUP BY PROF2

select * from PCNT

INSERT INTO PsCNT
SELECT PR, SUM(CNT) FROM PCNT GROUP BY PR

select * from PsCNT

SELECT PRs, sCNT FROM PsCNT WHERE sCNT = 
(SELECT MAX(sCNT) FROM PsCNT)

--79. Who are the male programmers earning below the AVG salary of Female Programmers? 
SELECT PNAME FROM PROGRAMMER WHERE GENDER LIKE 'M'
AND SALARY < (SELECT(AVG(SALARY)) FROM PROGRAMMER WHERE GENDER LIKE 'F');