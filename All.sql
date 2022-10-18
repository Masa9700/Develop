Create database Student
Create table Student(SID int, SNAME VARCHAR(50),SFEE MONEY,COURCEID INT)
SELECT * FROM Student
Create table Cource(COURCEID INT, CNAME VARCHAR(50),CFEE MONEY)
Select * from Cource
SELECT * FROM Student
use student
Table-1:-
-------
insert into Student values(107,'Sontham',200,2023)
insert into Student values(108,'Bamdam',1800,2022) 
insert into Student values(101,'Adam',1200,2021)
insert into Student values(102,'Sadam',3200,2020)
insert into Student values(103,'Madam',5200,2019) 
insert into Student values(104,'Badam',6200,2018)
insert into Student values(105,'kadam',2200,2017) 
Table-2:-
-------
insert into Cource values(2021,'Python',10200)
insert into Cource values(2020,'.net',8200)
insert into Cource values(2019,'Machine Learning',7200)
insert into Cource values(2018,'Sql server',12000)
insert into Cource values(2017,'Sql Dba',2800)

select * from Cource
select sum(Cfee) from Cource
select Cfee from cource
union
select sum(Cfee) from Cource

---Set Operators:-
-------------
Union:-
select Cfee from cource
Union
select Sfee from Student
--Union all:-
----------
select Cfee from cource
Union all
select Sfee from Student
--Intersect:-
---------

select Cfee from cource
intersect
select Sfee from Student
--Except:-
------

select Cfee from cource
Except
select Sfee from Student




---Rollup and Cube:-
---------------
select sname,sfee,count(*) as count from student group  by rollup(sfee,sname) 

select sname,sfee,count(*) from student group  by cube(sfee,sname) 



---Joins:-
Inner join:-
----------
select * from Student as s  inner join Cource as c on s.COURCEID=c.COURCEID
Left Outer join:-
---------------
select * from Student as s left Outer join Cource as c on s.COURCEID=c.COURCEID
Right Outer join:-
-----------------
select * from Student as s right Outer join Cource as c on s.COURCEID=c.COURCEID
Full Outer join:-
---------------
select * from Student as s full Outer join Cource as c on s.COURCEID=c.COURCEID
Cross Join:-
-----------
select * from Student cross join Cource

---Data memory storage information:-
--------------------------------
sp_spaceused student

---Operators:-
---------
And, OR,Between, <,>,=,>=,<=,!<,!>,!=.
-------------------------------------
select * from Student where SFEE=1200 
select * from Student where SFEE<1200 
select * from Student where SFEE>1200 
select * from Student where SFEE>=1200
select * from Student where SFEE<=1200
select * from Student where SFEE!<1200
select * from Student where SFEE!>1200
select * from Student where SFEE!=1200
select * from Student where SFEE>1200 and SNAME='Sadam'
select * from Student where SFEE<1200 or SFEE=1200
select Sfee from Student where SFEE between 1200 and 3200
select * from Student where SNAME like 'm____%'
----Constraints:-
------------
Unique Condition:-
--------------
Create table MSP(Eid int Unique, Ename varchar(40))
select * from MSP
insert into MSP values(101,'Siva')
insert into MSP values(101,'Siva')
Not Null Condition:-
------------------
Create table MSP1(Eid int Not Null, Ename varchar(40))
select * from MSP1
insert into MSP1 values(101,'Siva')
insert into MSP1 values(102,'Null')
insert into MSP values(Null,'Siva')
Check  Condition:-
-----------------
Create table MSP2(Eid int check(Eid<=1000), Ename varchar(40))
select * from MSP2
use master
insert into MSP2 values(1001,'Siva')
insert into MSP2 values(199,'Null')
insert into MSP2 values(Null,'Siva')
sp_spaceused Student

Agreegate Functions:-
-------------------
select * from Student
select count(*) as count from Student
select sum(Sfee) as total from Student
Select Min(Sfee) as Min from Student
Select Max(Sfee) as Min from Student
Select Avg(Sfee) as Min from Student
Select Min(Sfee) as Min,Max(sfee) as Max,Sum(sfee) as Sum,Count(Sfee) as count from Student
Select sname,Count(Sfee) as Count from Student group by SNAME order by Sname Desc 

T-SQL: Sub Block
1.Stored functin:-
----------------------
1. Scaller Valued Function :-
---------------------------
Create database Emp
use Emp
create table Emp_Gross ( EID int, ENAME varchar(50),ESALARY Money)
Select * from Emp_Gross
Insert into Emp_Gross values(101,'Veru',25000)
Insert into Emp_Gross values(102,'Siva Prasad',37000)
Insert into Emp_Gross values(103,'Shravya',48200)
Insert into Emp_Gross values(104,'Jiyan',16800)
Insert into Emp_Gross values(105,'Vamsi',19100)
Ex:-
1. Create a SVF to input employee id as a parameter and returns that employee gross salary based on the following conditions?
Condition 1:- HRA 10%
Condition 2:- DA 20%
Condition 3:- PF 10%
to find the Gross salary of the employee?

Create function SVF_1(@EID int)
returns money
as
begin
declare @BASIC money,@HRA money,@DA money,@PF money,@Gross money
select @BASIC=ESALARY from Emp_Gross where EID=@EID
set @HRA=@basic*0.1
set @DA=@basic*0.2
set @PF=@basic*0.1
set @Gross=@basic+@HRA+@DA+@PF
return @Gross 
end
select dbo.SVF_1 (101,102,103,104,105) as Gross - Its not working in SVF
select dbo.SVF_1 (105) as Gross - Its working in SVF due to SVF is taking single value return.

2. Table Value Function:-
------------------------
Create Function TVF_1 (@EID int)
returns table
as
return(Select * from Emp_Gross where EID=@EID)
select * from TVF_1 (101)
Select * from Emp_Gross
sp_spaceused Emp_Gross
T-SQL: Stored Procedure:-
------------------------
1. Stored Procedure Without Parameters:-
---------------------------------------
Create procedure SP1
as
begin
select * from Emp_Gross
end
execute Sp1

2. Stored Procedure With Parameters:-
-----------------------------------
Create procedure SP2(@EID int,@PF int Out)
as
begin
declare @sal money
select @sal=@ESALARY from Emp_Gross where EID=@EID
set @pf=@sal*0.1
end

Cursors in T-SQL:-
----------------
1.Declare
2.Open
3.Fetch
  i) First
 ii) Last
iii) Prior
 iv) Next
  V) Absolute n
 vi) Relative n
4.Close 
5.deallocate

Select * from Emp_Gross

Working without cursor variables:-
---------------------------------

declare c1 cursor scroll for select * from Emp_Gross
open c1
fetch last from c1
fetch First from c1
fetch Next from c1
fetch absolute 5 from c1
fetch relative -2 from c1
fetch prior from c1
close c1
deallocate c1

Working with cursor variables:-
-----------------------------
declare c1 cursor scroll for select EID,ENAME from Emp_Gross
declare @EID int,@ENAME varchar(50)
open c1
fetch last from c1 into @EID,@ENAME
print 'The Employee'+''+@ENAME+''+'ID IS:-'+cast(@EID as varchar)

SELECT GETUTCDATE();
SELECT MONTH('2022/02/05') AS Month;



Sub Queries:-
-----------
1. Non Corealted Sub Queries:-
    a). Single/single-row Sub Queries
	b). Multiple-row Sub Queries

a). Single/single-row Sub Queries:-
---------------------------------
select * from Emp_Gross where ESALARY=(select max(ESALARY)from Emp_Gross)

b). Multiple-row Sub Queries:-
-----------------------------
select * from Emp_Gross where ESALARY=(select max(ESALARY)from Emp_Gross where Esalary<(select max(ESALARY)from Emp_Gross))



2. Corealted Sub Queries:-







Views:-
-----

Create database Views_Test
use Views_Test
Create table Emp_Hyd(EID Int, ENAME varchar(40),ESALARY money)
Insert into Emp_Hyd values(101,'Scot',85000)
Insert into Emp_Hyd values(102,'James',25000)
Insert into Emp_Hyd values(103,'Adam',15000)
Insert into Emp_Hyd values(104,'Scary',35000)

Create table Emp_Chennai(EID Int, ENAME varchar(40),ESALARY money)
Insert into Emp_Chennai values(101,'Scot',85000)
Insert into Emp_Chennai values(105,'Warner',22000)
Insert into Emp_Chennai values(106,'Jadeja',28000)

select * from Emp_Hyd
select * from Emp_Chennai


1) Simple View:- Its perform on single base table. It can access DML operation.
---------------
Create view Msp as select * from Emp_Hyd 
select * from Msp
Insert into msp values (107,'katich',66600)
update msp set ename='Jar' where eid=102
delete msp  where eid=107



2).Complex View:- Its can access on multiple base table, it cannot access DML Operations.
----------------
Create view CV1 as select * from Emp_Hyd union
select * from Emp_Chennai 
select * from CV1

Primary Key And Forien key Constraints:-
--------------------------------------
Create table Primary_Key(SID int primary key,SNAME varchar(50),SCOURCE Varchar(50),SFEE money)
Insert into  Primary_Key values(101,'Siva','Java',12000)
Insert into  Primary_Key values(102,'Prasad','.Net',10000)
Insert into  Primary_Key values(103,'Shravya','Python',15000)
Insert into  Primary_Key values(104,'Veeru','MSBI',9500)




Create table Forien_Key(EID int,ENAME varchar(50),ECOURCE Varchar(50),EFEE money, SID int foreign key references Primary_Key(SID))
Select * from forien_Key
Insert into  forien_Key values(101,'Manchi','ADF',14000,101)
Insert into  forien_Key values(102,'Suresh','Framework',11000,102)
Insert into  forien_Key values(103,'Clara','Django',13000,103)

select *from Primary_Key as p inner join Forien_Key as F ON P.SID=F.EID
select *from Primary_Key as p left outer join Forien_Key as F ON P.SID=F.EID
select *from Primary_Key as p Right outer join Forien_Key as F ON P.SID=F.EID
select *from Primary_Key as p  full outer join Forien_Key as F ON P.SID=F.EID
select *from Primary_Key as p Cross join Forien_Key as F

execute sp_helpindex Primary_Key





