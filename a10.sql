use google

select * from Studies
select * from Software
select * from Programmer

--80. Who are the female programmers earning more than the highest paid?
select pname, salary , gender from programmer 
where gender = 'f' and salary > (select max(salary) from programmer)

--81. Which language has been stated as the proficiency by most of the
--programmers?

SELECT PROF1 FROM PROGRAMMER GROUP BY PROF1 HAVING PROF1 = (SELECT MAX(PROF1) FROM PROGRAMMER)
union
SELECT PROF2 FROM PROGRAMMER GROUP BY PROF2 HAVING PROF2 = (SELECT MAX(PROF2) FROM PROGRAMMER);

--82. Display the details of those who are drawing the same salary.

SELECT pname, salary FROM PROGRAMMER WHERE Salary IN
(SELECT SALARY FROM PROGRAMMER GROUP BY SALARY HAVING Count(SALARY) > 1);

--83. Display the details of the software developed by the male programmers
--earning more than 3000.

SELECT * FROM PROGRAMMER p,SOFTWARE s
where p.pname=s.pname and SALARY>3000 and gender='m';

--84. Display the details of the packages developed in Pascal by the female
--programmers.

SELECT s.* FROM PROGRAMMER p,SOFTWARE s
where p.pname=s.pname and developin='pascal' and gender='f';

--85. Display the details of the programmers who joined before 1990.
select  *  from programmer where 
year(dob) < 1990 

--86. Display the details of the software developed in C by the female
--programmers at Pragathi.

select s.* from software s,studies st,programmer p where s.pname=st.pname and p.pname=s.pname and gender='f' and institute='pragathi';

--87. Display the number of packages, number of copies sold and sales value
--of each programmer institute wise.

Select studies.institute, count(software.developin) AS developin, count(software.sold) As Sold, sum(software.sold*software.scost) AS sales from software,studies
where software.pname =studies.pname group by studies.institute;

--88. Display the details of the software developed in dBase by male
--programmers who belong to the institute in which the most number of
--programmers studied.

CREATE TABLE INST (INS VARCHAR(20), CNT INT)

INSERT INTO INST
SELECT INSTITUTE, COUNT(PNAME) FROM studies GROUP BY INSTITUTE

SELECT distinct SW.* FROM software AS SW, programmer AS PG, studies AS ST, INST
WHERE DEVELOPIN='DBASE' AND GENDER='M' AND SW.PNAME = PG.PNAME 
AND INSTITUTE = INS AND CNT= (SELECT MAX(CNT) FROM INST)

--89. Display the details of the software developed by the male programmers
--born before 1965 and female programmers born after 1975.

select * from software as s , programmer as p 
where p.pname=s.pname and ((gender='M' AND YEAR(DOB)<1965) OR (gender='F' AND YEAR(DOB)>1975));


--90. Display the details of the software that has been developed in the
--language which is neither the first nor the second proficiency of the
--programmers.

select s.* from software as s , programmer as p 
where p.pname=s.pname and ( developin <> prof1 and developin <> prof2) 

--91. Display the details of the software developed by the male students at
--Sabhari.

select p.pname, developin, gender, INSTITUTE from studies as s , software as ss , programmer as p 
where s.pname=ss.pname and p.pname=ss.pname and gender= 'm' and INSTITUTE = 'sabhari'

--92. Display the names of the programmers who have not developed any
--packages.

select pname from programmer where pname not in(select pname from software)

--93. What is the total cost of the software developed by the programmers of
--Apple?

select sum(scost) from software s,studies st where s.pname=st.pname and institute ='apple'

--94. Who are the programmers who joined on the same day?

select a.pname,a.doj
from programmer a,programmer b
where a.doj=b.doj and a.pname <> b.pname;

--95. Who are the programmers who have the same Prof2?

select distinct(a.pname),a.prof2 from programmer a,programmer b
where a.prof2=b.prof2 and a.pname <> b.pname;

--96. Display the total sales value of the software institute wise.

select studies.institute,sum(software.sold*software.scost) from software,studies
where studies.pname=software.pname group by studies.institute;

--97. In which institute does the person who developed the costliest package
--study?

select institute from software st,studies s
where s.pname=st.pname group by institute,dcost having dcost=(select max(dcost) from software)

--98. Which language listed in Prof1, Prof2 has not been used to develop any
--package?

select prof1 from programmer where prof1 not in(select developin from software) 
union
select prof2 from programmer where prof2 not in(select developin from software)

--99. How much does the person who developed the highest selling package
--earn and what course did he/she undergo?

select p1.salary,s2.course from programmer p1,software s1,studies s2
where p1.pname=s1.pname and s1.pname=s2.pname and scost=(select max(scost) from software)

--100. What is the average salary for those whose software sales is more than
--50,000?
select avg(salary) from programmer p,software s
where p .pname=s.pname and sold*scost>50000;

--101. How many packages were developed by students who studied in
--institutes that charge the lowest course fee?

select s.pname, count(title) As packages from software s,studies st
where s.pname=st.pname group by s.pname,course_fee having min(course_fee)=(select min(course_fee) from studies);

--102. How many packages were developed by the person who developed the
--cheapest package? Where did he/she study?

select count(developin) from programmer p,software s
where s .pname=p.pname group by developin having min(dcost)=(select min(dcost) from software);

--103. How many packages were developed by female programmers earning
--more than the highest paid male programmer?

select count(developin) from programmer p,software s
where s.pname=p.pname and gender='f' and salary>(select max(salary) from programmer p,software s
where s.pname=p.pname and gender='m');

--104. How many packages are developed by the most experienced
--programmers from BDPS?

select count(*) from software s,programmer p
where p.pname=s.pname group by doj having min(doj)=(select min(doj)
from studies st,programmer p, software s
where p.pname=s.pname and st.pname=p.pname and (institute='bdps'));

--105. List the programmers (from the software table) and the institutes they
--studied at.
select pname,institute from studies
where pname not in(select pname from software);

--106 List each PROF with the number of programmers having that PROF
--and the number of the packages in that prof 

select count(*),sum(scost*sold-dcost) "PROFIT" from software
where developin in (select prof1 from programmer) group by developin;

--107 List the programmer names (from the programmer table) and the
--number of packages each has developed.
select s.pname,count(developin) from programmer p1,software s
where p1.pname=s.pname group by s.pname;