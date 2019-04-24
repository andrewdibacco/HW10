create database College
GO

use college
GO

create table DepartmentTypes(
DepartmentTypeID int Identity Primary Key not null,
Type varchar(30) not null
)

create table ScoreTypes(
ScoreTypeID int Identity Primary Key not null,
Type varchar(25) not null
)

create table Students(
StudentID int Identity Primary Key not null,
FName varchar(25) not null,
LName varchar(25) not null,
SSN int not null,
Address varchar(125) not null,
City varchar(25) not null,
State varchar(25) not null,
Zip int not null,
Phone bigint not null,
)
GO


create table Classes(
ClassID int Identity Primary Key not null,
Title varchar(50) not null,
Number int not null,
DepartmentTypeID int Constraint FK_Classes_DepartmentTypeID Foreign Key references College.dbo.DepartmentTypes(DepartmentTypeID) not null
)
Go

create table StudentClasses(
StudentClassID int Identity Primary Key not null,
ClassID int Constraint FK_StudentClasses_ClassID Foreign Key references College.dbo.Classes(ClassID) not null,
StudentID int Constraint FK_StudentClasses_StudentID Foreign Key references College.dbo.Students(StudentID) not null
)
GO

create table Scores(
ScoreID int Identity Primary Key not null,
ScoreTypeID int Constraint FK_Scores_ScoreTypeID Foreign Key references College.dbo.ScoreTypes(ScoreTypeID) not null,
StudentClassID int Constraint FK_Scores_StudentClassID Foreign Key references College.dbo.StudentClasses(StudentClassID) not null,
Description varchar(200) not null,
DateAssigned datetime not null,
DateDue datetime not null,
DateSubmitted datetime not null,
PointsEarned int not null,
PointsPossible int not null,
)
GO

insert into DepartmentTypes(Type)
values('Mathematics'),
('English'),
('Philospophy'),
('Astronomy'),
('Economics')

insert into ScoreTypes(Type)
values('Homework'),
('Essay'),
('Quiz'),
('Lab'),
('Test')

insert into Students(FName, LName, SSN, Address, City, State, Zip, Phone)
values('Andrew', 'DiBacco', 123456789, '101 Wisteria Lane', 'Cleveland', 'Ohio','44094', 5554094902),
('Sam', 'Nasr', 111223333, '305 Brook Drive', 'Ohio City', 'Ohio', '44094', 5559084567),
('Alex', 'Shaw', 222334444, '120 Western Circle', 'McDonald', 'Pennsylvania', '32464', 4449053920)
GO

insert into Classes(Title, Number, DepartmentTypeID)
values('Algebra', 101, 1),
('British Literature', 205, 2),
('Advanced Philosophy', 301, 3);

insert into StudentClasses(ClassID,StudentID)
values (1,1),
(1,2),
(2,2),
(2,3),
(3,3)
GO

insert into Scores(ScoreTypeID, StudentClassID, Description, DateAssigned, DateDue, DateSubmitted,PointsEarned, PointsPossible)
values(1, 1,'Intro to algebra', '04-01-2019', '04-02-2019' , '04-02-2019', 8, 10),
(2,4, 'Beowulf', '04-05-2019', '04-23-2019' , '04-25-2019', 70, 100),
(3,2,'Balancing equations', '04-01-2019', '04-01-2019' , '04-01-2019', 11, 15)
GO

select 
	Classes.Title, 
	DepartmentTypes.Type as 'Department', 
	Students.FName, 
	Students.LName, 
	ScoreTypes.Type as 'ScoreType', 
	Description, 
	DateAssigned, 
	PointsEarned, 
	PointsPossible 
from Scores
Inner Join StudentClasses on Scores.StudentClassID = StudentClasses.StudentClassID
Inner Join ScoreTypes on Scores.ScoreTypeID = ScoreTypes.ScoreTypeID
inner join Classes on StudentClasses.ClassID = Classes.ClassID
inner join Students on StudentClasses.StudentID = Students.StudentID
inner join DepartmentTypes on Classes.DepartmentTypeID = DepartmentTypes.DepartmentTypeID
GO

--use master
--drop table Scores
--drop table StudentClasses
--drop table ScoreTypes
--drop table Students
--drop table Classes
--drop database College
--GO




