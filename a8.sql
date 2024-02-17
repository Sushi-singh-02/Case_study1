use google
select * from Studies
 select * from Software
 select * from Programmer

--26.What are the languages studied by male programmers?

select pname,prof1,prof2  from programmer where gender = 'm'

--27. What is the average salary?

select avg(salary) as avg_sal from programmer

--28. How many people draw a salary between 2000 to 4000?

select count(*) from programmer where salary between 4000 and 40000;

--29. Display the details of those who don’t know Clipper, COBOL or Pascal.

select * from programmer where prof1<>'clipper' and prof1<>'cobol' and prof1<>'pascal' and prof2<>'clipper' and prof2<>'cobol' and prof2<>'pascal' ;

--30. Display the cost of packages developed by each programmer.

select pname,sum(dcost) from software 
group by pname

--31. Display the sales value of the packages developed by each
--programmer.

select pname,sum(scost*sold) from software 
group by pname

--32. Display the number of packages sold by each programmer.

select pname, count(sold) as number_of_package_sold from software 
group by pname

--33. Display the sales cost of the packages developed by each programmer
--language wise.

select developin as language_wise ,sum(scost*sold) as sales_cost_of_package from software group by developin;

--34. Display each language name with the average development cost,
--average selling cost and average price per copy.

SELECT developin AS LANGUAGE,AVG(DCOST) AS AVGDEVCOST,AVG(SCOST) AS AVGSELLCOST,AVG(SCOST) AS PRICEPERCPY
FROM SOFTWARE GROUP BY developin;

--35. Display each programmer’s name and the costliest and cheapest
--packages developed by him or her.

SELECT pname As PRNAME,MIN(DCOST) As CHEAPEST,MAX(DCOST) AS COSTLIEST
FROM SOFTWARE GROUP BY pname;


--36. Display each institute’s name with the number of courses and the
--average cost per course.

SELECT institute ,count(course) As number_of_courses, AVG(course_fee) AS AVG_cost_per_course
FROM studies GROUP BY institute;

--37. Display each institute’s name with the number of students.

select institute,count(pname) as cnt from studies 
group by institute

--38. Display names of male and female programmers along with their
--gender.

select pname, gender from Programmer

--39. Display the name of programmers and their packages.

select pname, salary  from Programmer

--40. Display the number of packages in each language except C and C++.

select developin As language, count(title) As number_of_packages 
from software group by developin having developin<>'c' and developin!='c++';

--41. Display the number of packages in each language for which
--development cost is less than 1000.

select developin As language, count(title) As number_of_packages 
from software where dcost<1000 group by developin;

--42. Display the average difference between SCOST and DCOST for each
--package.

select title, avg(dcost-scost) as diff from software
group by title 

--43. Display the total SCOST, DCOST and the amount to be recovered for
--each programmer whose cost has not yet been recovered.

SELECT SUM(SCOST), SUM(DCOST), SUM(DCOST-(SOLD*SCOST)) FROM SOFTWARE GROUP BY pname HAVING SUM(DCOST)>SUM(SOLD*SCOST);


--44. Display the highest, lowest and average salaries for those earning more
--than 2000.

select  max(salary) as maximum , min(salary) as minimum , avg(salary) from programmer where salary < 20000

select  max(salary) as maximum from programmer 
select  min(salary) as maximum from programmer 
select  avg(salary) as average from programmer where salary < 20000


--45. Who is the highest paid C programmer?

SELECT * FROM PROGRAMMER WHERE SALARY =(SELECT MAX(SALARY) FROM PROGRAMMER WHERE PROF1 LIKE 'C' OR PROF2 LIKE 'C');


--46. Who is the highest paid female COBOL programmer?

SELECT * FROM PROGRAMMER WHERE SALARY=(SELECT MAX(SALARY) FROM PROGRAMMER WHERE (PROF1 LIKE 'COBOL' OR PROF2 LIKE 'COBOL')) AND gender LIKE 'F';


--47. Display the names of the highest paid programmers for each language.

WITH CTC AS (
  SELECT PNAME, SALARY, PROF1 AS PROF FROM programmer
  UNION 
  SELECT PNAME, SALARY, PROF2 FROM programmer
)
SELECT p1.PNAME, p1.PROF, p1.SALARY
FROM CTC as p1
LEFT JOIN CTC as 
p2
  ON p1.PROF = p2.PROF AND p1.SALARY < p2.SALARY
WHERE p2.PNAME IS NULL;

--48. Who is the least experienced programmer?

select pname, doj, getdate() as curr_date , datediff(yy,doj,getdate()) as experience from programmer 
order by experience 

--49. Who is the most experienced male programmer knowing PASCAL?

select pname, doj,gender,prof1,getdate() as curr_date , datediff(yy,doj,getdate()) as experience from programmer where gender = 'm' and prof1= 'pascal'
order by experience desc 


--50. Which language is known by only one programmer?

SELECT PROF1 FROM PROGRAMMER
GROUP BY PROF1
HAVING PROF1 NOT IN
(SELECT PROF2 FROM PROGRAMMER)
AND COUNT(PROF1)=1
UNION
SELECT PROF2 FROM PROGRAMMER
GROUP BY PROF2
HAVING PROF2 NOT IN
(SELECT PROF1 FROM PROGRAMMER)
AND COUNT(PROF2)=1;

--51. Who is the above programmer referred in 50?

CREATE TABLE PSLang(PROF VARCHAR(20))

Select * from pslang

INSERT INTO PSLang 
SELECT PROF1 FROM programmer 
GROUP BY PROF1 HAVING
PROF1 NOT IN (SELECT PROF2 FROM programmer) 
AND COUNT(PROF1)=1
UNION
SELECT PROF2 FROM programmer 
GROUP BY PROF2 HAVING
PROF2 NOT IN (SELECT PROF1 FROM programmer) 
AND COUNT(PROF2)=1

SELECT PNAME, PROF FROM programmer 
INNER JOIN PSLang ON
PROF=PROF1 OR PROF=PROF2


--52. Who is the youngest programmer knowing dBase?

SELECT pname, prof1, prof2, 
case
when dateadd(year, datediff(YEAR, dob, getdate()), dob)>getdate()
then datediff(YEAR, dob, getdate()) - 1
else
datediff(YEAR, dob, getdate()) end As Age
from programmer where dob = (SELECT max(dob) from programmer where prof1='dbase' or prof2='dbase');
