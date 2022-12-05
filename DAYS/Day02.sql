CREATE TABLE ogrenciler5
(
ogrenci_no char (7), -- uzunlugunu bildigimiz stringler icin CHAR kullanilir.
isim varchar (20), -- uzunlugunu bilmedigimiz stringler icin VARCHAR kullaniriz
soyisim varchar (25),
not_ort real, -- Ondalik sayilar icin kullanilir (Double gibi)
kayit_tarih date
);

--VAROLAN BIR TABLODAN YENI BIR TABLO OLUSTURMA
CREATE TABLE NOTLAR 
AS
SELECT isim,not_ort FROM ogrenciler5;

SELECT * from notlar;

--TABLO ICINE VERI EKLEME

INSERT INTO notlar VALUES ('Hanzel',95.5); -- ek satir eklemeden bir satiri degistirip degistirip ekleme yapabilirsin
INSERT INTO notlar VALUES ('Orhan',55.5);
INSERT INTO notlar VALUES ('Ali',85.5);
INSERT INTO notlar VALUES ('Musa',75.5);
INSERT INTO notlar VALUES ('Hakan',65.5);
INSERT INTO notlar VALUES ('Adem',65.5);

Create table talebeler
(
isim varchar(10),
notlar real
);
INSERT INTO talebeler VALUES ('Hanzel',95.5); -- ek satir eklemeden bir satiri degistirip degistirip ekleme yapabilirsin
INSERT INTO talebeler VALUES ('Orhan',55.5);
INSERT INTO talebeler VALUES ('Ali',85.5);
INSERT INTO talebeler VALUES ('Musa',75.5);
INSERT INTO talebeler VALUES ('Hakan',65.5);
INSERT INTO talebeler VALUES ('Adem',65.5);

SELECT * FROM notlar;


--CONSTRAINT
--UNIQEU
CREATE TABLE ogrenciler6
(
ogrenci_no char (7) unique,
isim varchar (20) not null, 
soyisim varchar (25),
not_ort real, 
kayit_tarih date
);
SELECT * FROM ogrenciler6;

INSERT INTO ogrenciler6 VALUES ('1234567','Hanzel','Karaagac',75.5,now());
INSERT INTO ogrenciler6 VALUES ('1234568','Ali','Veli',75.5,now());
INSERT INTO ogrenciler6 (ogrenci_no,soyisim,not_ort) VALUES ('1234569','Evren',85.5);--NOT NULL KISITLAMASI OLDUGU ICIN BU VERI EKLENEMEZ

-- PRIMARY KEY ATAMASI
CREATE TABLE ogrenciler9
(
ogrenci_no char (7) PRIMARY KEY,
isim varchar (20), 
soyisim varchar (25),
not_ort real, 
kayit_tarih date
);

-- PRIMARY KEY ATAMASI 1. yol
create table ogrenciler10
(
ogrenci_no char(7) PRIMARY KEY, 
isim varchar(20), 
soyisim varchar(25), 
not_ort real, 
kayit_tarih date
);
-- PRIMARY KEY ATAMASI 2. yol
create table ogrenciler11
(
ogrenci_no char(7), 
isim varchar(20), 
soyisim varchar(25), 
not_ort real,
kayit_tarih date,
CONSTRAINT ogr primary key(ogrenci_no)
);

--FOREIGN KEY

/*
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”, “iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/

CREATE TABLE tedarikciler3
(
tedarikci_id char (5) PRIMARY KEY,
tedarikci_ismi varchar(20),
iletisim_isim varchar(20)
);

CREATE TABLE urunler (
tedarikci_id char(5),
urun_id char(5),
FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
);

SELECT * FROM tedarikciler3;
SELECT * FROM urunler;

/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” field’lari olsun.
“id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve “sehir” fieldlari olsun. 
“adres_id” field‘i ile Foreign Key oluşturun.
*/
CREATE TABLE calisanlar
(
id varchar(15) PRIMARY KEY,
isim varchar(30) UNIQUE,
maas int NOT NULL,
ise_baslama date
);

CREATE TABLE adresler
(
adres_id varchar(30),
sokak varchar(30),
cadde varchar(30),
sehir varchar(30),
FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- NOT NULL CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- UNIQUE CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); -- INT / STRING girilmez
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); -- PRIMARY KEY
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- PRIMARY KEY
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');

-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

SELECT * FROM calisanlar;
SELECT * FROM adresler;


--CHECK CONSTRAINT

CREATE TABLE calisanlar2
(
id varchar(15) PRIMARY KEY,
isim varchar(30) UNIQUE,
maas int CHECK (maas>10000),
ise_baslama date
);

INSERT INTO calisanlar2 VALUES('10002', 'Mehmet Yılmaz' ,19000, '2018-04-14');


SELECT * FROM calisanlar2;

--DQL -- WHERE KULLANIMI

SELECT * FROM calisanlar;
SELECT  isim FROM calisanlar;

--Calisanlar tablosundan maasi 5000'den buyuk olan isimleri listeleyiniz.
SELECT isim,maas FROM calisanlar  WHERE  maas>5000;

-- Calisanlar tablosundan ismi Veli Han olan tum verileri getiriniz.
SELECT * FROM calisanlar WHERE isim='Veli Han';

-- Calisanlar tablosundan maasi 5000 olan tum verileri listeleyiniz.
SELECT * FROM calisanlar WHERE maas=5000;


--DML --DELETE KOMUTU
DELETE FROM calisanlar; --Eger parent tablo baska bir child tablo ile iliskili ise once child table silinmelidir.
DELETE FROM adresler; -- tum tablonun icindeki verileri siler
SELECT * FROM adresler;

--Adresler tablosundan sehiri Antep olan verileri silelim
DELETE FROM adresler WHERE sehir='Antep';



CREATE TABLE ogrenciler3
(
iid int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler3 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler3 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler3 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler3 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Ali', 99);

-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
DELETE FROM ogrenciler3 WHERE isim='Nesibe Yilmaz' or isim='Mustafa Bak';
