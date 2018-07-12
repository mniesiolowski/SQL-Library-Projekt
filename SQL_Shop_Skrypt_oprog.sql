create  database sklep;
go

use sklep;
go


--Usun tabele
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='faktura_produkt')
DROP TABLE faktura_produkt;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='faktura')
DROP TABLE faktura;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='produkty')
DROP TABLE produkty;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='klient')
DROP TABLE klient;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='dostawca')
DROP TABLE dostawca;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='kategorie')
DROP TABLE kategorie;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='Adresy')
DROP TABLE adresy


--Tworzymy Tabele
CREATE TABLE adresy
(
idAdresy INT PRIMARY KEY IDENTITY not null,
ulica VARCHAR(50),
miejsowosc VARCHAR(50),
kod VARCHAR(6)
)
GO

 CREATE TABLE klient
 (
idKlient INT PRIMARY KEY IDENTITY(10001,1) not null,
imie VARCHAR(15 ),
nazwisko VARCHAR(30),
ulica VARCHAR(30),
miejscowosc VARCHAR(30),
kod VARCHAR(6)
)
GO

INSERT INTO klient VALUES
('Adam','Adam','Zielona 12' , 'Gdañsk','80-298'),
('Karol','Karol','Nowa 3','Gdynia','44-444'),
('Joanna','Asia','Czerwona 484','Wroc³aw','88-373'),
('Grzegorz','Gorszek','Z³ota 99','Warszawa','01-999'),
('Anna','Marchewka','Turkusowa 55','Zakopane','33-229'),
('Wiktor','Burak','Czarna 69','Szczecin','76-555')

CREATE TABLE dostawca
 (
idDostawca INT PRIMARY KEY IDENTITY not null,
nazwa VARCHAR(50),
ulica VARCHAR(30),
miejscowosc VARCHAR(30),
kod VARCHAR(6)
)
GO

INSERT INTO dostawca VALUES
('Emilk','Purpurowa 159','Kraków','52-999'),('Fanex','Inna 11','Gdynia','44-837'),('FoodCare','Stylowa 22','Gdañsk','80-180'),
('Bochen','Niebieska 1 ','Wroc³aw','88-555'),('Sambor','Szara 87','Przemyœl','32-888'),('Konspol','Stara 22','Warszawa','01-555'),
('Milkpool','Ró¿owa 74','Szczecin','76-149'),('Mokate','Br¹zowa 1','Zakopane','33-449'),('Mlekovita','Bia³a 211','Przemyœl','32-799')


CREATE TABLE kategorie
 (
idKategorie INT PRIMARY KEY IDENTITY not null,
nazawa VARCHAR(50),
)
GO

INSERT INTO kategorie VALUES
('nabial'),('pieczywo'),('Napoje')

CREATE TABLE produkty
(
idProdukty INT PRIMARY KEY IDENTITY not null,
nazwa VARCHAR(30),
cena DECIMAL(10, 2),
Kategorie_idKategorie	INT CONSTRAINT  fk_Kategorie_idKategorie FOREIGN KEY (Kategorie_idKategorie)  REFERENCES kategorie(idKategorie),
Dostawca_idDostawca	INT CONSTRAINT  fk_Dostawca_idDostawca FOREIGN KEY (Dostawca_idDostawca)  REFERENCES Dostawca(idDostawca)
)
GO

INSERT INTO produkty VALUES

-- Kategoria nabial

('Mleko',3.50,1,7),
('Œmietana',4,1,7),
('Kefir',2.32,1,8),
('Twarog',2.55,1,8),
('Jogurt',0.90,1,9),
('Maslo',5.50,1,9),

--kategoria pieczywo

('Chleb',1.50,2,4),
('Chleb ziarnisty',3.10,2,4),
('Chleb razowy',3.50,2,5),
('Dro¿dzowka',1.50,2,5),
('P¹czek',1.50,2,6),
('Bu³ka',0.45,2,6),

--kategoria napoje

('woda',0.40,3,1),
('sok pomaranczowy',2.22,3,1),
('cola',3.32,3,2),
('cola zero',3.32,3,2),
('sok jablkowy',1.90,3,3),
('fanta',4.55,3,3)

CREATE TABLE faktura
(
idFaktura INT PRIMARY KEY IDENTITY(101,1) not null,
Klient_idKlient	INT CONSTRAINT  fk_Klient_idKlient FOREIGN KEY (Klient_idKlient)  REFERENCES klient(idKlient),
data_wsystawienia DATE

)
GO

INSERT INTO faktura VALUES 

(10001,'2016-11-23'),
(10002,'2017-08-13'),
(10003,'2017-01-05'),
(10002,'2017-02-10'),
(10006,'2017-03-03'),
(10001,'2017-04-03')

CREATE TABLE faktura_produkt
(
faktura_idFaktura INT CONSTRAINT  fk_faktura_idfaktura FOREIGN KEY (faktura_idfaktura)  REFERENCES faktura(idfaktura),
Produkty_idProdukty	INT CONSTRAINT  fk_Produkty_idProdukty FOREIGN KEY (Produkty_idProdukty)  REFERENCES Produkty(idProdukty),
ilosc INT
)
GO
INSERT INTO faktura_produkt VALUES
(101,2,500),
(101,4,20),
(101,5,33),
(102,9,3),
(102,1,4),
(102,6,100),
(105,8,500),
(105,1,11),
(105,7,18),
(106,10,1),
(106,11,222)

GO




--•Funkcja o nazwie UtworzFakture. Funkcja pobiera IDKlienta i powinna wyœwietlaæ informacje takie jak IDFaktury, nazwê klienta, 
--jego ID, datê utworzenia faktury oraz iloœæ zakupionych produktów wraz z sum¹ kosztów wszystkich produktów.

	IF OBJECT_ID ('UtworzFakture') IS NOT NULL  
    DROP FUNCTION UtworzFakture;  
	GO

CREATE FUNCTION dbo.UtworzFakture (@idklient int)
RETURNS TABLE
AS
RETURN
	SELECT faktura.idFaktura, klient.imie,klient.nazwisko,klient.idKlient,faktura.data_wsystawienia, SUM(ilosc) AS ilosc,SUM(cena*ilosc) AS wartosc FROM faktura
	INNER JOIN klient ON idKlient=faktura.Klient_idKlient
	INNER JOIN faktura_produkt ON idFaktura=faktura_produkt.faktura_idFaktura
	INNER JOIN produkty ON idProdukty=faktura_produkt.Produkty_idProdukty
	WHERE klient.idKlient=faktura.Klient_idKlient and idKlient=@idklient 
	GROUP BY faktura.idFaktura, klient.imie,klient.nazwisko,klient.idKlient,faktura.data_wsystawienia

GO

SELECT * FROM dbo. UtworzFakture(10002)

GO
--•Funkcja o nazwie DodajDoFaktury. Funkcja pobiera IDKlienta i powinna umo¿liwiaæ dodanie do istniej¹cej faktury kolejnego produktu.

	IF OBJECT_ID ('DodajDoFaktury') IS NOT NULL  
    DROP PROC DodajDoFaktury;  
GO  

CREATE PROC DodajDoFaktury (@id INT,@produkt INT,@ilosc INT)
AS
	INSERT INTO faktura_produkt VALUES (@id,@produkt,@ilosc) 
GO

EXEC DodajDoFaktury 101,14,2
EXEC DodajDoFaktury 101,2,2

SELECT * FROM faktura_produkt WHERE faktura_idFaktura=101 

--•Funkcja o nazwie PoliczRabat. Funkcja oblicza rabat dla klienta o zadanym IDKlienta. Rabat obliczany jest na podstawie wartoœci wszystkich zamówieñ klienta wed³ug nastêpuj¹cych kryteriów:
--•dla 1000 - 3000 PLN rabat 5%
--•dla 3000 - 10000 PLN rabat 7%
--•dla 10000 i wiêcej rabat 10%

	IF OBJECT_ID ('PoliczRabat') IS NOT NULL  
	DROP FUNCTION PoliczRabat;  
	GO

CREATE FUNCTION PoliczRabat (@idkl INT)
RETURNS INT 
BEGIN
DECLARE @rabat INT
DECLARE @wynik INT

SET @rabat = (SELECT SUM(cena*ilosc) AS wartosc FROM klient
	INNER JOIN faktura ON idKlient=faktura.Klient_idKlient
	INNER JOIN faktura_produkt ON idFaktura=faktura_produkt.faktura_idFaktura
	INNER JOIN produkty ON idProdukty=faktura_produkt.Produkty_idProdukty
	WHERE idKlient=@idkl) 

IF (@rabat<1000)
	SET @wynik=0
ELSE
IF (@rabat<3000)
	SET @wynik=5
ELSE 
IF (@rabat<10000)
	SET @wynik=7
ELSE
	SET @wynik=10
RETURN @wynik
END
	GO

SELECT dbo.PoliczRabat(10001) AS rabat

	GO



--widok o nazwie TrzechNajlepszych, który wyœwietli sumê wszystkich zamówieñ dla trzech najlepszych klientów sklepu

	IF OBJECT_ID ('TrzechNajlepszych') IS NOT NULL  
	DROP VIEW TrzechNajlepszych;  
	GO


CREATE VIEW TrzechNajlepszych
AS
	SELECT TOP 3  klient.imie,klient.nazwisko,SUM(cena*ilosc) AS wartosc FROM klient
	INNER JOIN  faktura ON idKlient=faktura.Klient_idKlient
	INNER JOIN faktura_produkt ON idFaktura=faktura_produkt.faktura_idFaktura
	INNER JOIN produkty ON idProdukty=faktura_produkt.Produkty_idProdukty
	GROUP BY klient.imie,klient.nazwisko ORDER BY SUM(cena*ilosc)

GO

SELECT * FROM TrzechNajlepszych

GO

--widok o nazwie WspolneMiasto, który wyœwietli dostawców i klientów pochodz¹cych z tego samego miasta wraz z ich danymi adresowymi.
	
	IF OBJECT_ID ('WspolneMiasto') IS NOT NULL  
	DROP VIEW WspolneMiasto;  
	GO

CREATE VIEW WspolneMiasto 
AS
	
	SELECT imie,nazwisko, klient.ulica AS ulica_klient,klient.miejscowosc AS klient_miasto,klient.kod AS klient_kod,nazwa, dostawca.ulica AS ulica_dostawca,dostawca.miejscowosc AS dostawca_miasto,dostawca.kod AS dostawca_kod  FROM klient, dostawca
	WHERE klient.miejscowosc=dostawca.miejscowosc
	
GO

SELECT * FROM WspolneMiasto

GO

--widok o nazwie WyswietlDostawcow, który wyœwietli najwa¿niejsze dane zwi¹zane ze wszystkimi dostawcami w bazie danych.

	IF OBJECT_ID ('WyswietlDostawcow') IS NOT NULL  
	DROP VIEW WyswietlDostawcow;  
	GO

CREATE VIEW WyswietlDostawcow
AS
	SELECT  dostawca.idDostawca,  dostawca.nazwa ,ulica ,miejscowosc,kod FROM dostawca
	
GO

SELECT * FROM WyswietlDostawcow
 


--Procedura o nazwie WyswietlFaktury, która wyœwietli podstawowe informacje o wszystkich fakturach 
--w bazie danych. Wyœwietlane dane powinny zawieraæ IDFaktury, nazwê klienta, jego ID, datê utworzenia faktury 
--oraz iloœæ zakupionych produktów wraz z sum¹ kosztów wszystkich produktów.

	IF OBJECT_ID ('WyswietlFaktury') IS NOT NULL  
	DROP PROC WyswietlFaktury;  
	GO

CREATE PROC WyswietlFaktury
AS
	SELECT faktura.idFaktura, klient.imie,klient.nazwisko,klient.idKlient,faktura.data_wsystawienia, SUM(ilosc) AS ilosc, SUM(cena*ilosc) AS wartosc FROM faktura
	INNER JOIN klient ON idKlient=faktura.Klient_idKlient
	INNER JOIN faktura_produkt ON idFaktura=faktura_produkt.faktura_idFaktura
	INNER JOIN produkty ON idProdukty=faktura_produkt.Produkty_idProdukty
	GROUP BY faktura.idFaktura, klient.imie,klient.nazwisko,klient.idKlient,faktura.data_wsystawienia ORDER BY idFaktura
GO

EXEC WyswietlFaktury

--Procedura o nazwie WyswietlPozycjeFaktury, która wyœwietli wszystkie produkty z faktury o podanym IDFaktury.
 
	IF OBJECT_ID ('WyswietlPozycjeFaktury') IS NOT NULL  
	DROP PROC WyswietlPozycjeFaktury;  
	GO


CREATE PROC WyswietlPozycjeFaktury(@IDfk INT)
AS
	SELECT faktura_produkt.faktura_idFaktura, produkty.nazwa AS PRODUKT FROM faktura_produkt
	INNER JOIN produkty ON idProdukty=faktura_produkt.Produkty_idProdukty
	WHERE faktura_produkt.faktura_idFaktura=@IDfk
GO

EXEC WyswietlPozycjeFaktury 105