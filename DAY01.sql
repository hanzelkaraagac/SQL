--DATABASE(VERITABANI) Olusturma
Create dataBase evren;

create database erol;

--DDL - DATA DEFINITION LANGUAGE
--CREATE --TABLO OLUSTURMA
CREATE TABLE ogrenciler2
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real, --ondalikli sayilar icin real kullanilir (Double gibi)
kayit_tarihi date
);

--VAR OLAN TABLODAN YENI BIR TABLO OLUSTURMA
CREATE TABLE ogrenci_notlari
AS -- Benzer tablodaki basliklarla ve data tipleriyle yeni bir tablo olusturmak icin
   -- normal tablo olustururken ki parantezler yerine AS kullanip Select komutuyla almak istedigimiz verileri aliriz.
SELECT isim,soyisim,not_ort FROM ogrenciler1;

-- DML - DATA MANUPULATION LANGUAGE
-- INSERT (Database'e veri ekleme)

INSERT INTO ogrenciler1 VALUES ('1234567','Hanzel','KARAAGAC',85.5,now()); --now bugunun tarihini ekler
INSERT INTO ogrenciler1 VALUES ('1234567','Hanzel','KARAAGAC',85.5,'2022-12-11');

-- BIR TABLOYA PARCALI VERI EKLEMEK ISTERSEK

INSERT INTO ogrenciler1 (isim,soyisim) VALUES ('Erol','Evren');


-- DQL - DATA QUERY LANGUAGE
-- SELECT

select * FROM ogrenciler1; -- * ==> buradaki sembol herseyi degistir demektir


