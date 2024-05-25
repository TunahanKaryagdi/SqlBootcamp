CREATE DATABASE SqlBootcamp

USE SqlBootcamp

CREATE TABLE Companies(
   Id int identity(1,1) primary key,
   Name nvarchar(50)
)

CREATE TABLE Users(
   Id int identity(1,1) primary key,
   Name nvarchar(20),
   Surname nvarchar(20)
)

CREATE TABLE Categories(
	Id int identity(1,1) primary key,
	Name nvarchar(50),
)


CREATE TABLE Jobs(
   Id int identity(1,1) primary key,
   CompanyId int foreign key(CompanyId) references Companies(Id),
   CategoryId int foreign key(CategoryId) references Categories(Id),
   Title nvarchar(20),
   CreatedDate date,
   Salary int
)


CREATE TABLE Applications(
	Id int identity(1,1) primary key,
	JobId int foreign key(JobId) references Jobs(Id),
	UserId int foreign key(UserId) references Users(Id),
)


CREATE TABLE AuditJobLogs(
	Id int identity(1,1) primary key,
	JobId int foreign key(JobId) references Jobs(Id),
	CompanyId int foreign key(CompanyId) references Companies(Id),
	Title nvarchar(20),
	Salary int,
	CreatedDate date,
	ProcessType nvarchar(10),
)




CREATE TABLE AuditUserLogs(
	Id int identity(1,1) primary key,
	UserId int foreign key(UserId) references Users(Id),
	Name nvarchar(20),
    Surname nvarchar(20),
	CreatedDate date,
	ProcessType nvarchar(10),
)





