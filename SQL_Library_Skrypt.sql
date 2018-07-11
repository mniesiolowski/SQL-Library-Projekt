/*-----------------------------------------------------------
					DROP TABLE
------------------------------------------------------------*/
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='wypozyczenie')
DROP TABLE wypozyczenie;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='Bibliotekarz')
DROP TABLE Bibliotekarz;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='Czytelnik')
DROP TABLE Czytelnik;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='Ksiazka')
DROP TABLE Ksiazka;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='Autor')
DROP TABLE Autor;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='Kategoria')
DROP TABLE Kategoria;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='Termin')
DROP TABLE Termin;
GO
/*-----------------------------------------------------------
					CREATE TABLE
------------------------------------------------------------*/

CREATE TABLE Czytelnik (
  idCzytelnika       INT		 IDENTITY(1000001,1) PRIMARY KEY, 
  Imie				 VARCHAR(10) NOT NULL,
  Nazwisko			 VARCHAR(30) NOT NULL,
  Adres				 VARCHAR(40) NOT NULL,
  Miasto			 VARCHAR(20) NOT NULL,
  Kod_pocztowy		 VARCHAR(8) NOT NULL,
  PESEL				 VARCHAR(11) NOT NULL UNIQUE,
);
GO 

CREATE TABLE Kategoria (
  idKategoria       INT   IDENTITY(11,1)  PRIMARY KEY,
  Nazwa				VARCHAR(30) NOT NULL UNIQUE
);
GO

CREATE TABLE Autor (
  idAutora		INT  IDENTITY(101,1)  PRIMARY KEY,
  Imie			VARCHAR(20) NOT NULL,
  Nazwisko		VARCHAR(30) NOT NULL
);
GO

CREATE TABLE Ksiazka (
  idKsiazka				INT  IDENTITY(10001,1)  PRIMARY KEY,
  Autor_idAutor			INT	     CONSTRAINT  fk_Autor_idAutor FOREIGN KEY (Autor_idAutor)  REFERENCES Autor(idAutora),
  Kategoria_idKategoria INT    CONSTRAINT  fk_Kategoria_idKategoria FOREIGN KEY (Kategoria_idKategoria) REFERENCES Kategoria(idKategoria),
  Tytul					VARCHAR(50)	   NOT NULL,
  ISBN					INT	   NOT NULL UNIQUE,
  Rok_wydania			DATE   NOT NULL
);
GO

CREATE TABLE Termin (
  idTermin				INT IDENTITY(10000001,1) PRIMARY KEY,
  data_wypozyczenia		DATE NOT NULL,
  Data_oddania			DATE 

);
GO

CREATE TABLE Bibliotekarz (
  idBibliotekarz	INT IDENTITY(9001,1) PRIMARY KEY,
  Imie				VARCHAR(20) NOT NULL,
  Nazwisko			VARCHAR(30) NOT NULL

);
GO

CREATE TABLE wypozyczenie (
  idWypozyczenie				 INT	IDENTITY(300000001,1)	PRIMARY KEY,
  Czytelnik_idCzytelnika         INT	CONSTRAINT fk_Czytelnik_idCzytelnika FOREIGN KEY REFERENCES Czytelnik(idCzytelnika),
  Bibliotekarz_idBibliotekarza   INT	CONSTRAINT fk_Bibliotekarz_idBibliotekarza FOREIGN KEY REFERENCES Bibliotekarz(idBibliotekarz),
  Ksiazka_idKsiazka				 INT    CONSTRAINT fk_Ksiazka_idKsiazka FOREIGN KEY REFERENCES Ksiazka(idKsiazka),
  Termin_idTermin				 INT    CONSTRAINT fk_Termin_idTermin FOREIGN KEY  REFERENCES Termin(idTermin),
  );
GO

/*-----------------------------------------------------------
			Rekordy dla tabeli Bibliotekarz
------------------------------------------------------------*/

INSERT INTO Bibliotekarz(Imie,Nazwisko)
VALUES ('Brat', 'Pitt');

INSERT INTO Bibliotekarz(Imie,Nazwisko)
VALUES ('Angelina', 'Joli');

INSERT INTO Bibliotekarz(Imie,Nazwisko)
VALUES ('Dawid', 'Duchowny');

INSERT INTO Bibliotekarz(Imie,Nazwisko)
VALUES ('Robert', 'Kubica');

INSERT INTO Bibliotekarz(Imie,Nazwisko)
VALUES ('Jola', 'Lojalna');
GO
/*-----------------------------------------------------------
			Rekordy dla tabeli Autor
------------------------------------------------------------*/

INSERT INTO Autor(Imie,Nazwisko)
VALUES ('Stanis³aw', 'Lem');

INSERT INTO Autor(Imie,Nazwisko)
VALUES ('Terry', 'Pratchett');

INSERT INTO Autor(Imie,Nazwisko)
VALUES ('Wanda', 'Chotomska');

INSERT INTO Autor(Imie,Nazwisko)
VALUES ('S³awomir', 'Mro¿ek');

INSERT INTO Autor(Imie,Nazwisko)
VALUES ('Tadeusz', 'Ró¿ewicz');

INSERT INTO Autor(Imie,Nazwisko)
VALUES ('Gal', 'Anonim');
GO
/*-----------------------------------------------------------
			Rekordy dla tabeli Kategoria
------------------------------------------------------------*/

INSERT INTO Kategoria(Nazwa)
VALUES ('SI-FI');
INSERT INTO Kategoria(Nazwa)
VALUES ('DLA DZIECI');
INSERT INTO Kategoria(Nazwa)
VALUES ('DRAMAT');
INSERT INTO Kategoria(Nazwa)
VALUES ('POEZJA');
INSERT INTO Kategoria(Nazwa)
VALUES ('LEKTURA SZKOLNA');
INSERT INTO Kategoria(Nazwa)
VALUES ('FANTASY');
INSERT INTO Kategoria(Nazwa)
VALUES ('INNE');
GO

/*-----------------------------------------------------------
			Rekordy dla tabeli	Ksi¹¿ka
------------------------------------------------------------*/

INSERT INTO Ksiazka(Autor_idAutor,Kategoria_idKategoria,Tytul,ISBN,Rok_wydania)
VALUES (101, 11,'Solaris','1234567890','1961');

INSERT INTO Ksiazka(Autor_idAutor,Kategoria_idKategoria,Tytul,ISBN,Rok_wydania)
VALUES (101, 11,'Cyberiad','0987654321','1965');

INSERT INTO Ksiazka(Autor_idAutor,Kategoria_idKategoria,Tytul,ISBN,Rok_wydania)
VALUES (102, 16,'Mort','1111111111','1987');

INSERT INTO Ksiazka(Autor_idAutor,Kategoria_idKategoria,Tytul,ISBN,Rok_wydania)
VALUES (102, 17,'Good Omens','222222222','1990');

INSERT INTO Ksiazka(Autor_idAutor,Kategoria_idKategoria,Tytul,ISBN,Rok_wydania)
VALUES (103, 12,'tere-Fere','333333333','2014');

INSERT INTO Ksiazka(Autor_idAutor,Kategoria_idKategoria,Tytul,ISBN,Rok_wydania)
VALUES (103, 12,'PAN MOTOREK','444444444','2014');

INSERT INTO Ksiazka(Autor_idAutor,Kategoria_idKategoria,Tytul,ISBN,Rok_wydania)
VALUES (104, 13,'Policja','0101010101','2017');

INSERT INTO Ksiazka(Autor_idAutor,Kategoria_idKategoria,Tytul,ISBN,Rok_wydania)
VALUES (104, 13,'Emigranci','400000001','2017');

INSERT INTO Ksiazka(Autor_idAutor,Kategoria_idKategoria,Tytul,ISBN,Rok_wydania)
VALUES (105, 14,'No¿yk profesora','200000002','2001');

INSERT INTO Ksiazka(Autor_idAutor,Kategoria_idKategoria,Tytul,ISBN,Rok_wydania)
VALUES (105, 17,'Mother Departs','300000003','2002');

INSERT INTO Ksiazka(Autor_idAutor,Kategoria_idKategoria,Tytul,ISBN,Rok_wydania)
VALUES (106, 15,'Lektura szkolna nr1','400000006','1830');

INSERT INTO Ksiazka(Autor_idAutor,Kategoria_idKategoria,Tytul,ISBN,Rok_wydania)
VALUES (106, 11,'Coœ nudnego','000012103','2017');

INSERT INTO Ksiazka(Autor_idAutor,Kategoria_idKategoria,Tytul,ISBN,Rok_wydania)
VALUES (106, 12,'Poczytaj mi tato','100000001','2000');
GO
/*-----------------------------------------------------------
			Rekordy dla tabeli	Czytelnik
------------------------------------------------------------*/

INSERT INTO Czytelnik(Imie,Nazwisko,Adres,Miasto,Kod_pocztowy,PESEL)
VALUES ('Marek','Kowalski','Ul. Zielona 12','Gdañsk','80-298','84090965521');

INSERT INTO Czytelnik(Imie,Nazwisko,Adres,Miasto,Kod_pocztowy,PESEL)
VALUES ('Patryk','Radomski','Ul. Wielkopolska 122','81-222','Gdynia','56100825256');

INSERT INTO Czytelnik(Imie,Nazwisko,Adres,Miasto,Kod_pocztowy,PESEL)
VALUES ('Jacek','Zieliñski' ,'Ul. Œwiêtokrzyska 6','Kowale','80-180','69031570117');

INSERT INTO Czytelnik(Imie,Nazwisko,Adres,Miasto,Kod_pocztowy,PESEL)
VALUES ('Karolina', 'Adamus' ,'Ul. Aldony 33','Pruszcz Gdañski', '83-000','90052110771');

INSERT INTO Czytelnik(Imie,Nazwisko,Adres,Miasto,Kod_pocztowy,PESEL)
VALUES ('Anna', 'Marzec','Ul. Ho¿a 10','Gdañsk' ,'80-616','78121105662');
GO
/*-----------------------------------------------------------
			Rekordy dla tabeli	Termin
------------------------------------------------------------*/
INSERT INTO Termin(data_wypozyczenia,Data_oddania)
VALUES ('2017-01-05','2017-02-05');
INSERT INTO Termin(data_wypozyczenia,Data_oddania)
VALUES ('2017-05-30',NULL);
INSERT INTO Termin(data_wypozyczenia,Data_oddania)
VALUES ('1999-03-22',NULL);
INSERT INTO Termin(data_wypozyczenia,Data_oddania)
VALUES ('2016-09-03','2017-03-21');
INSERT INTO Termin(data_wypozyczenia,Data_oddania)
VALUES ('2010-01-20','2010-05-21');
INSERT INTO Termin(data_wypozyczenia,Data_oddania)
VALUES ('2017-05-31','2017-06-01');
INSERT INTO Termin(data_wypozyczenia,Data_oddania)
VALUES ('2013-05-31','2013-09-01');
GO
/*-----------------------------------------------------------
			Rekordy dla tabeli	wypozyczenie
------------------------------------------------------------*/
INSERT INTO wypozyczenie(Czytelnik_idCzytelnika,Bibliotekarz_idBibliotekarza,Ksiazka_idKsiazka,Termin_idTermin)
VALUES (1000001,9001,10001,10000001);

INSERT INTO wypozyczenie(Czytelnik_idCzytelnika,Bibliotekarz_idBibliotekarza,Ksiazka_idKsiazka,Termin_idTermin)
VALUES (1000002,9002,10002,10000002);

INSERT INTO wypozyczenie(Czytelnik_idCzytelnika,Bibliotekarz_idBibliotekarza,Ksiazka_idKsiazka,Termin_idTermin)
VALUES (1000003,9003,10003,10000003);

INSERT INTO wypozyczenie(Czytelnik_idCzytelnika,Bibliotekarz_idBibliotekarza,Ksiazka_idKsiazka,Termin_idTermin)
VALUES (1000004,9004,10004,10000004);

INSERT INTO wypozyczenie(Czytelnik_idCzytelnika,Bibliotekarz_idBibliotekarza,Ksiazka_idKsiazka,Termin_idTermin)
VALUES (1000005,9005,10005,10000005);

INSERT INTO wypozyczenie(Czytelnik_idCzytelnika,Bibliotekarz_idBibliotekarza,Ksiazka_idKsiazka,Termin_idTermin)
VALUES (1000005,9001,10006,10000006);

INSERT INTO wypozyczenie(Czytelnik_idCzytelnika,Bibliotekarz_idBibliotekarza,Ksiazka_idKsiazka,Termin_idTermin)
VALUES (1000001,9001,10007,10000001);

INSERT INTO wypozyczenie(Czytelnik_idCzytelnika,Bibliotekarz_idBibliotekarza,Ksiazka_idKsiazka,Termin_idTermin)
VALUES (1000002,9004,10008,10000002);

INSERT INTO wypozyczenie(Czytelnik_idCzytelnika,Bibliotekarz_idBibliotekarza,Ksiazka_idKsiazka,Termin_idTermin)
VALUES (1000003,9004,10009,10000003);

INSERT INTO wypozyczenie(Czytelnik_idCzytelnika,Bibliotekarz_idBibliotekarza,Ksiazka_idKsiazka,Termin_idTermin)
VALUES (1000004,9001,10010,10000004);

INSERT INTO wypozyczenie(Czytelnik_idCzytelnika,Bibliotekarz_idBibliotekarza,Ksiazka_idKsiazka,Termin_idTermin)
VALUES (1000005,9001,10011,10000005);

INSERT INTO wypozyczenie(Czytelnik_idCzytelnika,Bibliotekarz_idBibliotekarza,Ksiazka_idKsiazka,Termin_idTermin)
VALUES (1000005,9001,10012,10000007);

INSERT INTO wypozyczenie(Czytelnik_idCzytelnika,Bibliotekarz_idBibliotekarza,Ksiazka_idKsiazka,Termin_idTermin)
VALUES (1000005,9003,10013,10000002);

INSERT INTO wypozyczenie(Czytelnik_idCzytelnika,Bibliotekarz_idBibliotekarza,Ksiazka_idKsiazka,Termin_idTermin)
VALUES (1000005,9003,10001,10000002);

GO