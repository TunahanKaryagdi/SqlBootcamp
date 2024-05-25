-- kullanýcý silindiðinde user logs tablosuna ekleme yapar
CREATE TRIGGER trgAfterDeleteOnUsers
ON Users
INSTEAD OF DELETE
AS BEGIN
	
	declare @userId int
	declare @name nvarchar(20)
	declare @surname nvarchar(20)
	SELECT @userId = deleted.Id, @name = deleted.Name, @surname = deleted.Surname FROM deleted
	INSERT INTO AuditUserLogs(UserId,Name,Surname,CreatedDate,ProcessType)
	VALUES (@userId,@name,@surname,GETDATE(),'Deleted')

END

-- kullanýcý güncellendiðinde user logs tablosuna ekleme yapar
CREATE TRIGGER trgAfterUpdateOnUsers
ON Users
AFTER UPDATE
AS BEGIN
	
	declare @userId int
	declare @name nvarchar(20)
	declare @surname nvarchar(20)
	SELECT @userId = inserted.Id, @name = inserted.Name, @surname = inserted.Surname FROM inserted
	INSERT INTO AuditUserLogs(UserId,Name,Surname,CreatedDate,ProcessType)
	VALUES (@userId,@name,@surname,GETDATE(),'Updated')

END

UPDATE Users SET Surname = 'Yeni' WHERE Id = 1000

-- iþ silindiðinde jobs logs tablosuna ekleme yapar.
CREATE TRIGGER trgAfterDeleteOnJobs
ON Jobs
INSTEAD OF DELETE
AS BEGIN
	
	declare @jobId int
	declare @companyId int
	declare @title nvarchar(20)
	declare @salary int
	SELECT @jobId = deleted.Id, @companyId = deleted.CompanyId, @title = deleted.Title, @salary = deleted.Salary FROM deleted
	INSERT INTO AuditJobLogs(JobId,CompanyId,Title,Salary,CreatedDate,ProcessType)
	VALUES (@jobId,@companyId,@title,@salary,GETDATE(),'Deleted')

END
DELETE FROM Jobs WHERE Id = 5000

-- iþ güncellendiðinde jobs logs tablosuna ekleme yapar
CREATE TRIGGER trgAfterUpdateOnJobs
ON Jobs
AFTER UPDATE
AS BEGIN
	
	declare @jobId int
	declare @companyId int
	declare @title nvarchar(20)
	declare @salary int
	SELECT @jobId = inserted.Id, @companyId = inserted.CompanyId, @title = inserted.Title, @salary = inserted.Salary FROM inserted
	INSERT INTO AuditJobLogs(JobId,CompanyId,Title,Salary,CreatedDate,ProcessType)
	VALUES (@jobId,@companyId,@title,@salary,GETDATE(),'Updated')

END

UPDATE Jobs SET Salary = 6000 WHERE Id = 1000

-- kullanýcýyla ilgili bütün bilgileri siler
CREATE PROCEDURE sp_DeleteUser 
	@userId int
AS BEGIN
	set nocount on
	DELETE FROM Applications WHERE UserId = @userId
	DELETE FROM Users WHERE Id = @userId
END

EXEC sp_DeleteUser 3

-- verilen iþe baþvuran kullanýcýlarý getirir.
CREATE PROCEDURE sp_GetApplicationsByJobId
	@jobId int
AS BEGIN
	set nocount on
	SELECT a.JobId, u.Name, u.Surname FROM Applications a 
	JOIN Users u ON a.UserId = u.Id
	WHERE JobId = @jobId
END

EXEC sp_GetApplicationsByJobId 5

-- verilen kullanýcýnýn baþvurduðu iþleri getirir.
CREATE PROCEDURE sp_GetApplicationsByUserId
	@userId int
AS BEGIN
	set nocount on
	SELECT a.UserId, c.Name, j.Title, j.Salary FROM Applications a
	JOIN Jobs j ON a.JobId = j.Id
	JOIN Companies c ON j.CompanyId = c.Id
	WHERE UserId = 5
END

EXEC sp_GetApplicationsByUserId 5


-- verilen iþe kaç adet baþvuru geldiðini gösterir
CREATE PROCEDURE sp_GetApplicationCountByJobId
	@jobId int
AS BEGIN
	set nocount on
	SELECT a.JobId, c.Name AS Company ,j.Title, COUNT(*) AS ApplicationCount
	FROM Applications a
	JOIN Jobs j ON a.JobId = j.Id
	JOIN Companies c ON j.CompanyId = c.Id
	GROUP BY JobId, j.Title, c.Name
	HAVING a.JobId = @jobId
END

EXEC sp_GetApplicationCountByJobId 1780

-- kategoriler ve ortalama maaþlarý getirir.
CREATE VIEW GetAvgSalaryByCategories 
AS
	SELECT j.CategoryId, c.Name, AVG(j.Salary) AS AvgSalary
	FROM Jobs j
	JOIN Categories c ON j.CategoryId = c.Id
	GROUP BY j.CategoryId, c.Name;

SELECT * FROM GetAvgSalaryByCategories

-- þirketler ve þirketteki iþlerin ortalama maaþlarý
CREATE VIEW GetAvgSalaryByCompanies
AS
	SELECT j.CompanyId, c.Name ,AVG(j.Salary) AS AvgSalary 
	FROM Jobs j
	JOIN Companies c ON j.CompanyId = c.Id
	GROUP BY CompanyId, c.Name;

SELECT * FROM GetAvgSalaryByCompanies ORDER BY AvgSalary DESC

-- þirketler ve iþ sayýlarýný getirir.
CREATE VIEW GetCompanyJobsCount
AS
	SELECT j.CompanyId, c.Name,COUNT(*) AS JobCount 
	FROM Jobs j  
	JOIN Companies c ON j.CompanyId = c.Id
	GROUP BY j.CompanyId, c.Name

SELECT * FROM GetCompanyJobsCount
