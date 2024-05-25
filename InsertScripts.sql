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
	('Sat�� ve Pazarlama'),
	('�nsan Kaynaklar�'),
	('E�itim ve ��retim'),
	('Sa�l�k ve T�p'),
	('Medya ve �leti�im'),
	('Sanat ve Tasar�m'),
	('�n�aat ve Mimarl�k'),
	('Hukuk ve Dan��manl�k'),
	('Enerji ve �evre'),
	('Tar�m ve G�da'),
	('Lojistik'),
	('Otomotiv ve Ula��m'),
	('Turizm ve Konaklama'),
	('Bilim ve Teknoloji'),
	('Moda ve Giyim'),
	('Spor ve Fitness'),
	('Yarat�c� Yazarl�k'),
	('Restoran ve Gastronomi'),
	('Ev ve Dekorasyon'),
	('Seyahat ve Macera'),
	('Y�netim Dan��manl���'),
	('E�lence ve Etkinlikler'),
	('Sa�l�k ve Refah'),
	('Tar�m ve Hayvanc�l�k'),
	('E-ticaret ve Perakende'),
	('Reklam ve Pazarlama'),
	('E�lence ve Oyunlar'),
	('Hobi ve El Sanatlar�');
	

INSERT INTO	Users (Name,Surname) VALUES
	('Ahmet','�en'),
	('Ali','Tan'),
	('Altu�','Kayac�'),
	('Erman','Ta�ar'),
	('Emre','Bozcan'),
	('Metin','Serin'),
	('�nder','Oyac�'),
	('Ali','Korkmaz'),
	('Hur�ut','Merdiven'),
	('�lhan','Cans�z'),
	('�lhan','Yaprak'),
	('Hakan','Teker'),
	('Mustafa','Dal'),
	('Atilla','Soyalp'),
	('Atiye','Nadir'),
	('Elif','Eyl�l'),
	('Bet�l','Kad�rga'),
	('Hale','�at�ro�lu'),
	('Derya','�ak�r'),
	('Bahar','Son'),
	('Nefise','Can'),
	('Damla','Karadere'),
	('Merve','Toy'),
	('Tar�k','Yap�c�'),
	('Taner','Yan�'),
	('�mit','Tekir'),
	('Ayhan','Bozac�'),
	('Tunahan','Karya�d�'),
	('Ertu�rul','Ayd�nl�k'),
	('Selahattin','Ezel'),
	('Serta�','Madalya'),
	('Ertem','Yener'),
	('Tu�rul','Yara'),
	('Kadir','Kayra'),
	('Hakan','�eker'),
	('Mustafa','Dalaman'),
	('Atilla','Soya'),
	('Atiye','�at�r'),
	('Elif','Ekim'),
	('Beyza','Sad�rga'),
	('Helin','Kat�ro�lu'),
	('Derya','�ak�ro�lu'),
	('Bahar','�lk'),
	('Nefise','Bandana'),
	('Damla','Tetik'),
	('Merve','B�y�ktank');


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







