-- Database olusturma
Create database techproed;

-- DDL - DATA DEFINITION LANG.
-- CREATE - TABLO OLUSTURMA
CREATE TABLE ogrenciler2
(
ogrenci_no char (7),
isim varchar (20),
soyisim varchar (25),
not_ort real, -- Ondalik sayilar icin kullanilir (Double gibi)
kayit_tarih date
);

--VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA
CREATE TABLE ogrenci_notlari
AS -- Benzer tablodaki başlıklarla ve data tipleriyle yeni bir tablo oluşturmak için
-- normal tablo oluştururken ki parantezler yerine AS kullanıp Select komutuyla almak istediğimiz verileri alırız
SELECT isim, soyisim, not_ort FROM ogrenciler2;

-- DML - DATA MANUPULATION LANG.
-- INSERT (Database'e veri ekleme)
INSERT INTO ogrenciler2 VALUES ('1234567', 'Hanzel', 'KARAAGAC', 85.5, now ());
INSERT INTO ogrenciler2 VALUES ('1234567', 'Hanzel', 'karaagac', 85.5,'2020-12-11') ;

--BIR TABLOYA PARÇALI VERT EKLEMEK ‡STERSEK
INSERT INTO ogrenciler2 (isim, soyisim) VALUES ('Erol', 'Evren');


-- DQL - DATA QUERY LANG.
SELECT * FROM ogrenciler2;