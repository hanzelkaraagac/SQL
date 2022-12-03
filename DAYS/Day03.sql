CREATE TABLE ogrenciler10
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

iNSERT INTO ogrenciler10 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler10 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler10 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler10 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler10 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler10 VALUES(127, 'Mustafa Bak', 'Ali', 99);
select * from ogrenciler10;

-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
delete from ogrenciler10 where isim = 'Nesibe Yilmaz' or isim = 'Mustafa Bak';
delete from ogrenciler10 where veli_isim = 'Hasan';

--DML -- truncate kullanmi
--Truncate hepsini siler ama spesifik silmez.(sartli silme yapmaz)
truncate ogrenciler10;-- ikiside olur

truncate table ogrenciler10;

-- ON delete CASCADE

drop table if exists talebeler-- varsa talebeler tablosunu siler

drop table if exists notlar


CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan', 75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse', 85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan', 85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse', 95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can', 99);
INSERT INTO notlar VALUES ('123','kimya', 75);
INSERT INTO notlar VALUES ('124', 'fizik', 65);
INSERT INTO notlar VALUES ('125', 'tarih', 90);
INSERT INTO notlar VALUES ('126', 'Matematik', 90);
select * from talebeler;
select * from notlar;
-- notlar tablosundan talebe_id'si 123 olan datayi silelim.
delete from notlar where talebe_id='123';-- childdan siler ama parentten silmez
--talebeler tablosunda id si 126 olani silelim
delete from talebeler where id=126;-- parentdan silersek childaki veride silinir
-- on delete cascade kullanirsak..
--1. tablolardan veri silmek icin.. normalde oncelikle  childdaki datayi silmemiz gerekir.
--2. child da on delete cascade kullanirsak... parent'dan datayi silebiliriz.
--3. bu durumda data hem parenttan hemde childdan silinir.
--IN CONDİTİON
drop table if exists musteriler  --- varsa musteriler tablosunu siler.
CREATE TABLE musteriler (
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');
select * from musteriler;
--musteriler tablosundan urun ismi Orange APple Apricot olan datalari listeleyiniz.
select * from musteriler where  urun_isim ='Orange' or urun_isim ='Apple' or urun_isim ='Apricot'
select * from musteriler where  urun_isim in ('Orange', 'Apple', 'Apricot');
-- ikiside ayni ise yapar
--NOT IN---> disindakileri
select * from musteriler where  urun_isim not in ('Orange', 'Apple', 'Apricot');
-- orange apple ve apricot disindakileri getir.
--BETWEEN CONDITION
--between 20 and 40 dersek 20 ve 40 dhil
select * from musteriler where urun_id>=20 and  urun_id <=40 ;
select * from musteriler where urun_id between 20 and 40;
-- ikiside ayni isi yapar.
--NOT BETWEEN
select * from musteriler where urun_id<20  or  urun_id >40 ;
select * from musteriler where urun_id not  between 20 and 40;
-- ikiside ayni isi yapar.
--SUBQUERIES-- baska bir sordugunun icinde calisan sorgu
CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);
INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', null, 'Vakko');


CREATE TABLE markalar
(
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);
INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
INSERT INTO markalar VALUES(104, 'Nike', 19000);

select * from calisanlar2;
select * from markalar;


-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini
--ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin.
select isim,maas, isyeri from calisanlar2
where isyeri in (select marka_isim from markalar where calisan_sayisi>15000);


--Marka_id'si 101'den buyuk olan marka calisanlarinin 
--isim, maas ve sehirlerini listeleyiniz.

SELECT isim,maas,sehir FROM calisanlar2 
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE marka_id>101);


--AGGREGATE METHOD

--Calisanlarin tablosunun maksimum maasi listeleyelim
SELECT MAX(maas) AS maksimum_maas FROM calisanlar2; --AS kullanmazsak max yerine istedigimiz bir seyi yazdirabiliriz
SELECT MAX(maas)  FROM calisanlar2;

/*
	Eger bir sutuna gecici olarak bir isim vermek istersek AS komutunu yazdiktan sonra
vermek istedigimiz ismi yazariz.
*/

--Calisanlar tablosundan minimum maasi listeleyelim
SELECT Min(maas) AS minimum_maas FROM calisanlar2;
SELECT min(maas)  FROM calisanlar2;

--Calisanlar tablosundaki maaslarin toplamini listeleyiniz
select sum(maas) from calisanlar2; --sum ile toplamini aliriz

--Calisanlarin tablosundaki maas'larin ortalamasini listeleyiniz
SELECT AVG(maas) FROM calisanlar2; --AVG ile ortalamasini aliriz

SELECT ROUND (AVG(maas)) FROM calisanlar2; --Sadece sayiyi verdi noktadan sonrasini vermedi

SELECT ROUND (AVG(maas),2) FROM calisanlar2; -- noktadan sonra 2 sayi verdi

--Calisanlar tablosundaki maas'larin sayisini listeleyiniz
SELECT count(maas) FROM calisanlar2; --count dedigimiz de satirlari sayiar
--ikisinin arasindaki fark eger null varsa * koydugumuzda onu sayar ama maas olarak yazdigimizda onu saymayacaktir.
SELECT count(*) FROM calisanlar2; -- yildizda koysak satirlari sayacaktir. --null olsada satir sayacaktir.

DELETE FROM calisanlar2;

/*
Eger count(*) kullanirsak tablodaki tum satirlarin sayisini verir.
Sutun adi kullanirsak o sutundaki sayilari verir.
*/

--AGGREGATE METHODLARDA SUBQUERY
--Her markanin id'sini, ismini ve toplam kac sehirde bulundugunu listeleyen bir SORGU yaziniz

select * from calisanlar2;
select * from markalar;

SELECT marka_id,marka_isim,
(SELECT count(sehir)  FROM calisanlar2
WHERE marka_isim=isyeri) FROM markalar;


SELECT marka_id,marka_isim,
(SELECT count(sehir)  AS sehir_sayisi FROM calisanlar2 --count yazan yere sehir yazisi yazdik
WHERE marka_isim=isyeri) FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz

SELECT marka_isim,calisan_sayisi,
(SELECT sum(maas) FROM calisanlar2 WHERE isyeri=marka_isim) AS toplam_maas
FROM markalar


-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin 
-- maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.

SELECT marka_isim,calisan_sayisi,
(SELECT Max(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as enyuksekmaask,
(SELECT Min(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as endusukmaas
FROM markalar;


--VIEW KULLANIMI
/*
Yaptigimiz sorgulari hafizaya alir ve tekrar bizden istenen sorgulama yerine
view'e atadigimiz ismi SELECT komutuyla cagiririz.
*/
Create VIEW maxminmaas
AS
SELECT marka_isim,calisan_sayisi,
(SELECT Max(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as enyuksekmaask,
(SELECT Min(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as endusukmaas
FROM markalar;

SELECT * FROM maxminmaas;

-- 							EXISTS CONDITION
/*
EXISTS Condition subquery’ler ile kullanilir. IN ifadesinin kullanımına benzer
olarak, EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen değerlerin içerisinde
bir değerin olması veya olmaması durumunda işlem yapılmasını sağlar
*/

CREATE TABLE mart
(   
urun_id int,    
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');


CREATE TABLE nisan 
(   
urun_id int ,
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

SELECT * FROM mart;
SELECT * FROM nisan;

/*
--MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
 URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
 MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.
*/

SELECT urun_id,musteri_isim FROM mart
WHERE exists (SELECT urun_id from nisan WHERE mart.urun_id=nisan.urun_id);

/*
--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
*/

SELECT urun_isim,musteri_isim FROM nisan
WHERE exists(SELECT urun_isim FROM mart WHERE mart.urun_isim=nisan.urun_isim);

--DML ==> (ic mimar tablonun icerisindeki verileri guncelleme) --UPDATE
--UPDATE
drop table if exists tedarikciler

CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');


CREATE TABLE urunler -- child
(
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler(vergi_no)
on delete cascade
);    
INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

SELECT * FROM tedarikciler;
SELECT * FROM urunler;

/*
UPDATE tablo_adi
SET sutun_ismi = 'Istenen veri' WHERE sutun_ismi='istenen veri'; 
*/

-- vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
UPDATE tedarikciler
SET firma_ismi = 'Vestel' WHERE vergi_no=102; 

-- vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
UPDATE tedarikciler
SET firma_ismi = 'Caper' ,irtibat_ismi='Ali Veli' WHERE vergi_no=101;

-- urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.
UPDATE urunler
SET urun_isim = 'Telefon' WHERE urun_isim='Phone';

-- urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.
UPDATE urunler
SET urun_id=urun_id + 1 WHERE urun_id>1004;

-- urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz.
UPDATE urunler 
SET urun_id = urun_id + ted_vergino;

DELETE FROM tedarikciler;
DELETE FROM urunler;


--* urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci  tablosunda irtibat_ismi 
--'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.
UPDATE urunler                      
SET urun_isim = (SELECT firma_ismi FROM tedarikciler WHERE irtibat_ismi = 'Adam Eve')                       
WHERE musteri_isim='Ali Bak';

--Urunler tablosunda laptop satin alan musterilerin ismini,
--firma_ismi Apple’in irtibat_isim’i ile degistirin.
UPDATE urunler
Set musteri_isim = (SELECT irtibat_ismi FROM tedarikciler WHERE firma_ismi='Apple')
WHERE urun_isim='Laptop';

SELECT * FROM tedarikciler;
SELECT * FROM urunler;

