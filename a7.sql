use  google
select * from Studies
 select * from Software
 select * from Programmer

--1. Find out the selling cost average for packages developed in Pascal.

select avg(scost) from software
WHERE Developin like 'pascal';

--2. Display the names and ages of all programmers.

SELECT pname, dob, 
case
when dateadd(year, datediff(YEAR, dob, getdate()), dob)>getdate()
then datediff(YEAR, dob, getdate()) - 1
else
datediff(YEAR, dob, getdate()) end As age
from programmer;

select getdate() as today, pname, dob, datediff(YEAR, dob, getdate()) As 'age' from programmer;

--3. Display the names of those who have done the DAP Course.

select pname , course from studies where course = 'dap'

--4. Display the names and date of birth of all programmers born in January.

SELECT DOB,pname
FROM PROGRAMMER
WHERE dob like '_____01___';

--5. What is the highest number of copies sold by a package?

select max(sold) as maxx,title from software
group by title 
order by maxx desc

--or--
select max(sold) as highest from software 

--6. Display lowest course fee.

select min(course_fee) from studies

--7. How many programmers have done the PGDCA Course?

select * from studies where course = 'pgdca'

--or--

SELECT COUNT(pname)
FROM STUDIES
WHERE COURSE LIKE 'PGDCA';

--8. How much revenue has been earned through sales of packages
--developed in C?

select sum(scost*sold) from software where developin = 'c'

--9. Display the details of the software developed by Ramesh.

select developin from software where pname = 'ramesh'

--10. How many programmers studied at Sabhari?

select count(pname) from studies where institute = 'sabhari'

--11. Display details of packages whose sales crossed the 2000 mark.

select * from software where (scost*sold) > '2000'

--12. Display the details of packages for which development costs have been
--recovered.

select * from software where (scost*sold) > dcost

--13. What is the cost of the costliest software development in Basic?

select max(dcost) from software;


--14. How many packages have been developed in dBase?

SELECT count(title) FROM software where developin = 'dbase';

--15. How many programmers studied in Pragathi?

SELECT count(pname) FROM studies where institute = 'sabhari';

--16. How many programmers paid 5000 to 10000 for their course?

select * from studies where course_fee >= '5000' and course_fee <= '10000'
--or--
select count(pname) from studies where course_fee between 5000 and 10000;

--17. What is the average course fee?

select avg(course_fee) as average_course_fee from studies 

--18. Display the details of the programmers knowing C.

SELECT * FROM software where developin = 'c'

--19. How many programmers know either COBOL or Pascal?

SELECT * FROM PROGRAMMER WHERE PROF1='COBOL' OR PROF1='PASCAL' OR PROF2='COBOL' OR PROF2='PASCAL';

--20. How many programmers don’t know Pascal and C?

SELECT * FROM PROGRAMMER WHERE PROF1!='C' OR PROF1!='PASCAL' OR PROF2!='C' OR PROF2!='PASCAL';

--21. How old is the oldest male programmer?

SELECT max(
case
when dateadd(year, datediff(YEAR, dob, getdate()), dob)>getdate()
then datediff(YEAR, dob, getdate()) - 1
else
datediff(YEAR, dob, getdate()) end) As age
from programmer;



--22. What is the average age of female programmers?

SELECT AVG(
case
when dateadd(year, datediff(YEAR, dob, getdate()), dob)>getdate()
then datediff(YEAR, dob, getdate()) - 1
else
datediff(YEAR, dob, getdate()) end) As age
from programmer where gender like 'f';


--23. Calculate the experience in years for each programmer and display with
--their names in descending order.

SELECT pname, doj, 
case
when dateadd(year, datediff(YEAR, doj, getdate()), doj)>getdate()
then datediff(YEAR, doj, getdate()) - 1
else
datediff(YEAR, doj, getdate()) end As experience
from programmer order by pname desc;

--24. Who are the programmers who celebrate their birthdays during the
--current month?

SELECT pname, dob, 
case
when dateadd(year, datediff(YEAR, dob, getdate()), dob)>getdate()
then datediff(YEAR, dob, getdate()) - 1
else
datediff(YEAR, dob, getdate()) end As age
from programmer
where MONTH(dob)= 12;

--25. How many female programmers are there?

select count(gender) from programmer where gender='f'


