INSERT INTO Companies (Name) VALUES 
	('NovaTech Solutions'),
	('BlueSky Innovations'),
	('Stellar Enterprises'),
	('GreenLeaf Ventures'),
	('Apex Horizons'),
	('TrueNorth Services'),
	('TerraFirma Industry'),
	('Vanguard Insights'),
	('SilverLine Strategy'),
	('Pioneer Vision'),
	('Aurora Enterprises'),
	('Sapphire Solutions'),
	('Zenith Innovations'),
	('Evergreen Dynamics'),
	('Nimbus Technologies'),
	('Ascend Ventures'),
	('Lumina Holdings'),
	('Radiant Strategies'),
	('Radiant Strategies'),
	('Infinite Horizons'),
	('Celestial Systems');

INSERT INTO Categories (Name) VALUES
	('Bilgi Teknolojileri'),
	('Finans ve Muhasebe'),
	('Satýþ ve Pazarlama'),
	('Ýnsan Kaynaklarý'),
	('Eðitim ve Öðretim'),
	('Saðlýk ve Týp'),
	('Medya ve Ýletiþim'),
	('Sanat ve Tasarým'),
	('Ýnþaat ve Mimarlýk'),
	('Hukuk ve Danýþmanlýk'),
	('Enerji ve Çevre'),
	('Tarým ve Gýda'),
	('Lojistik'),
	('Otomotiv ve Ulaþým'),
	('Turizm ve Konaklama'),
	('Bilim ve Teknoloji'),
	('Moda ve Giyim'),
	('Spor ve Fitness'),
	('Yaratýcý Yazarlýk'),
	('Restoran ve Gastronomi'),
	('Ev ve Dekorasyon'),
	('Seyahat ve Macera'),
	('Yönetim Danýþmanlýðý'),
	('Eðlence ve Etkinlikler'),
	('Saðlýk ve Refah'),
	('Tarým ve Hayvancýlýk'),
	('E-ticaret ve Perakende'),
	('Reklam ve Pazarlama'),
	('Eðlence ve Oyunlar'),
	('Hobi ve El Sanatlarý');
	

INSERT INTO	Users (Name,Surname) VALUES
	('Ahmet','Þen'),
	('Ali','Tan'),
	('Altuð','Kayacý'),
	('Erman','Taþar'),
	('Emre','Bozcan'),
	('Metin','Serin'),
	('Önder','Oyacý'),
	('Ali','Korkmaz'),
	('Hurþut','Merdiven'),
	('Ýlhan','Cansýz'),
	('Ýlhan','Yaprak'),
	('Hakan','Teker'),
	('Mustafa','Dal'),
	('Atilla','Soyalp'),
	('Atiye','Nadir'),
	('Elif','Eylül'),
	('Betül','Kadýrga'),
	('Hale','Þatýroðlu'),
	('Derya','Çakýr'),
	('Bahar','Son'),
	('Nefise','Can'),
	('Damla','Karadere'),
	('Merve','Toy'),
	('Tarýk','Yapýcý'),
	('Taner','Yaný'),
	('Ümit','Tekir'),
	('Ayhan','Bozacý'),
	('Tunahan','Karyaðdý'),
	('Ertuðrul','Aydýnlýk'),
	('Selahattin','Ezel'),
	('Sertaç','Madalya'),
	('Ertem','Yener'),
	('Tuðrul','Yara'),
	('Kadir','Kayra'),
	('Hakan','Þeker'),
	('Mustafa','Dalaman'),
	('Atilla','Soya'),
	('Atiye','Þatýr'),
	('Elif','Ekim'),
	('Beyza','Sadýrga'),
	('Helin','Katýroðlu'),
	('Derya','Çakýroðlu'),
	('Bahar','Ýlk'),
	('Nefise','Bandana'),
	('Damla','Tetik'),
	('Merve','Büyüktank');


declare @chars varchar(36) = 'ABCDEFGHIJKLMNOPRSTUVYZ'
declare @length int = 20

declare @startDate date = '2024-04-10'
declare @endDate date = '2024-05-25'

declare @counter int = 0

while @counter < 15000
begin
	declare @i int = 0
    declare @title varchar(20) = ''

	declare @randomDay int = ABS(CHECKSUM(NEWID())) % (DATEDIFF(DAY, @StartDate, @EndDate) + 1)
	declare @companyId int
	declare @categoryId int
	declare @salary int

    while @i < @length
    begin
        set @title = @title + SUBSTRING(@Chars, CAST((RAND() * 36) AS INT) + 1, 1)
        set @i = @i + 1
    end

	SELECT TOP 1 @companyId = Id FROM Companies ORDER BY NEWID()
	set @salary = 1000 + ABS(CHECKSUM(NEWID())) % 9001

	SELECT TOP 1 @categoryId = Id FROM Categories ORDER BY NEWID()

	INSERT INTO Jobs (CompanyId,CategoryId,Title,CreatedDate,Salary)
	VALUES (@companyId,@categoryId,@title,DATEADD(DAY,@randomDay,@startDate),@salary)

	set @counter = @counter + 1
end




declare @counter int = 0
while @counter < 90000
begin
	
	declare @jobId int
	declare @userId int

	SELECT TOP 1 @jobId = Id FROM Jobs ORDER BY NEWID()
	SELECT TOP 1 @userId = Id FROM Users ORDER BY NEWID()

	if EXISTS (SELECT 1 FROM Applications WHERE JobId = @jobId AND UserId = @userId)
		begin
			print('already exists')
		end
    else
		begin

			INSERT INTO Applications (JobId, UserId)
			VALUES (@jobId, @userId);
		end

	set @counter = @counter + 1
end







