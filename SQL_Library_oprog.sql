SELECT * FROM Czytelnik;
SELECT * FROM Bibliotekarz;
SELECT * FROM Ksiazka;
SELECT * FROM Autor;
SELECT * FROM Kategoria;
SELECT * FROM Termin;
SELECT * FROM wypozyczenie;

SELECT 'Iloœci rekordów:';

SELECT 
  (SELECT COUNT(*) FROM Czytelnik) AS Czytelnik,
  (SELECT COUNT(*) FROM Bibliotekarz) AS Bibliotekarz,
  (SELECT COUNT(*) FROM Ksiazka) AS Ksiazka,
  (SELECT COUNT(*) FROM Autor) AS Autor,
  (SELECT COUNT(*) FROM Kategoria) AS Kategoria,
  (SELECT COUNT(*) FROM Termin) AS Termin,
  (SELECT COUNT(*) FROM wypozyczenie) AS wypozyczenie
--------------------------------------------------------------------------------
		
	--wyswietl ksiazki które zosta³y wypo¿yczone i oddane w przedziale od do.
	SELECT idWypozyczenie,Czytelnik.Imie AS Imiê_Czytelnika, Czytelnik.Nazwisko AS Nazwisko_Czytelnika,Ksiazka.Tytul, Termin.data_wypozyczenia, Termin.Data_oddania,Bibliotekarz.Imie AS Imiê_Bibliotekarza, Bibliotekarz.Nazwisko AS Nazwisko_Bibliotekarza
	FROM wypozyczenie
	INNER JOIN  Bibliotekarz ON Bibliotekarz_idBibliotekarza=Bibliotekarz.idBibliotekarz
	INNER JOIN  Czytelnik ON Czytelnik_idCzytelnika=Czytelnik.idCzytelnika
	INNER JOIN  Ksiazka ON Ksiazka_idKsiazka=Ksiazka.idKsiazka
	INNER JOIN  Termin ON Termin_idTermin=Termin.idTermin
	WHERE Termin.Data_oddania IS NOT NULL AND Termin.data_wypozyczenia BETWEEN '20001212' AND '20170101'
	ORDER BY Termin.data_wypozyczenia
	--WHERE Termin.Data_oddania IS NULL --Zakomentowaæ argument u góry(WHERE...) i odkomentowaæ ten(dac go przed ORDER BY) aby pokazaæ NIE oddane ksi¹¿ki


	-- wyswietl skiazki o danej kategori i danego autora i sprawdz czy ksiazka jest na stanie czy nie(jak nie to od kiedy)
	SELECT Tytul, Imie, Nazwisko ,ISBN, Nazwa,
	CASE
		WHEN CAST(Data_oddania AS VARCHAR(15)) IS NOT NULL THEN CAST(Data_oddania AS VARCHAR(15))
		ELSE 'Dostêpna'
	END AS Dostêpnoœæ
	FROM Ksiazka 
	INNER JOIN Kategoria ON Kategoria_idKategoria=idKategoria
	INNER JOIN Autor ON Autor_idAutor=idAutora 
	INNER JOIN wypozyczenie ON idKsiazka=Ksiazka_idKsiazka
	INNER JOIN Termin ON Termin_idTermin=idTermin
	WHERE  (Kategoria_idKategoria='12' OR Kategoria_idKategoria='15') AND Nazwisko='Anonim' 

--Procedura Update wypozyczenia 
IF OBJECT_ID (N'oddajKsiazke', N'U') IS NOT NULL  
    DROP PROCEDURE oddajKsiazke;  
GO  

CREATE PROCEDURE oddajKsiazke (@idWypozyczenia int)    
AS 
BEGIN
	UPDATE Termin SET [Data_oddania] = CAST(GETDATE() AS DATE)
	  FROM wypozyczenie INNER JOIN
		 Termin ON Termin_idTermin=Termin.idTermin
	  WHERE idWypozyczenie=@idWypozyczenia

END 
GO

--wywo³anie procedury
DECLARE @idWypozyczenia INT = '300000002'

EXEC oddajKsiazke @idWypozyczenia



