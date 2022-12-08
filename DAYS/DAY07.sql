--DISTINCT KULLANIMI

CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);


INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

SELECT * FROM musteri_urun;

--Musteri urun tablosundan urun isimlerini tekrarsiz listeleyiniz.

--GROUP BY COZUMU
SELECT urun_isim FROM musteri_urun GROUP BY urun_isim;

--DISTINCT COZUMU
SELECT DISTINCT (urun_isim) FROM musteri_urun; --parantezsiz'de kullanilabilir

-- Tabloda kac farkli meyve vardir ?
SELECT count(DISTINCT urun_isim) FROM musteri_urun
GROUP BY urun_isim;

SELECT urun_isim, count(DISTINCT urun_isim) FROM musteri_urun
GROUP BY urun_isim; --meyveleride gormek icin. tek cesitleri gosterdi

SELECT urun_isim, count( urun_isim) FROM musteri_urun
GROUP BY urun_isim; --meyveleride gormek icin. kac adet oldugunu gosterdi (kac tane meyveden kacar tane var)

--Count, toplam meyve sayısı... Distinct meyve çeşit sayısı



-- FETCH NEXT (SAYI) ROW ONLY / OFFSET / LIMIT

-- Musteri urun tablosundan ilk 3 kaydi listeleyiniz
--FETCH NEXT (SAYI) ROW ONLY 
SELECT * FROM musteri_urun ORDER BY urun_id
FETCH NEXT 3 ROW ONLY;

--LIMIT
SELECT * FROM musteri_urun ORDER BY urun_id
LIMIT 3;

-- Musteri urun tablosundan ilk kaydi listeleyiniz.
--FETCH NEXT (SAYI) ROW ONLY 
SELECT * FROM musteri_urun ORDER BY urun_id
FETCH NEXT 1 ROW ONLY;

--LIMIT
SELECT * FROM musteri_urun ORDER BY urun_id
LIMIT 1;

-- Musteri urun tablosundan son uc kaydi listeleyiniz.
--LIMIT
SELECT * FROM musteri_urun ORDER BY urun_id DESC 
LIMIT 3;

--FETCH NEXT (SAYI) ROW ONLY 
SELECT * FROM musteri_urun ORDER BY urun_id DESC 
LIMIT 3;



CREATE TABLE maas
(
id int, 
musteri_isim varchar(50),
maas int 
);

INSERT INTO maas VALUES (10, 'Ali', '5000'); 
INSERT INTO maas VALUES (10, 'Ali', '7500'); 
INSERT INTO maas VALUES (20, 'Veli', '10000'); 
INSERT INTO maas VALUES (30, 'Ayse', '9000'); 
INSERT INTO maas VALUES (20, 'Ali', '6500'); 
INSERT INTO maas VALUES (10, 'Adem', '8000'); 
INSERT INTO maas VALUES (40, 'Veli', '8500'); 
INSERT INTO maas VALUES (20, 'Elif', '5500');

SELECT * FROM maas;

--En yuksek maasi alan musteriyi listeleyiniz.
SELECT * FROM maas ORDER BY maas DESC LIMIT 1;

-- Maas tablosundan en yüksek ikinci maası listeleyiniz
SELECT * FROM maas ORDER BY maas DESC offset 1 limit 1

/*
OFFSET --> Satır atlamak istediğimizde offset komutunu kullanırız
*/

SELECT * FROM maas ORDER BY maas desc
OFFSET 1 
FETCH NEXT 1 ROW ONLY

-- Maas tablosundan en düşük dördüncü maası listeleyiniz
SELECT * FROM maas ORDER BY maas offset 3 limit 1

-- DDL --> ALTER TABLE
drop table personel -- Tabloyu ortadan kaldırmak için kullanılır


CREATE TABLE personel  (
id int,
isim varchar(50), 
sehir varchar(50), 
maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);


INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');
SELECT * FROM personel


-- 1) ADD default deger ile tabloya bir field ekleme
ALTER TABLE personel
add zipcode varchar(30)


ALTER TABLE personel
ADD adres varchar(50) DEFAULT 'Turkiye' -- DEFAULT yazarsak oluşturduğumuz sütüna belirttiğimiz veriyi tüm satırlara girer

-- 2) DROP tablodan sutun silme
ALTER TABLE personel
DROP COLUMN zipcode;

ALTER TABLE personel
DROP COLUMN ulke;

ALTER TABLE personel
drop adres, DROP sirket; -- iki sutunu birden sildik

-- 3) RENAME COLUMN sutun adi degistirme
ALTER TABLE personel
RENAME COLUMN sehir TO il;

SELECT * FROM personel;

-- 4) RENAME Tablonun ismini degistirme
ALTER TABLE personel
RENAME TO isci;

SELECT * FROM isci;

-- 5) TYPE/SET(MODIFY) sutunlarinin ozelliklerini degistirme
ALTER TABLE isci
ALTER COLUMN il TYPE varchar(30),
ALTER COLUMN maas SET NOT NULL;
/*
--Eger numerik data turune sahip bir sutunun data turune string bir data turu atamak istersek
TYPE varchar(30) USING (maas::varchar(30)) bu formati kullaniriz.
*/
ALTER COLUMN maas -- ALTER TABLE isci kismini control tusu ile 165. satirdaki  kodu secip calistirabilirsiniz
TYPE varchar(30) USING (maas::varchar(30));


drop table ogrenciler13;



--TRANSACTION (BEGIN - SAVEPOINT - ROLLBACK - COMMIT)
/*
Transaction baslatmak icin BEGIN komutu kullanmamiz gerekir 
ve transaction'i sonlandirmak icin commit komutunu calistirmaliyiz.
*/

CREATE TABLE ogrenciler13
(
id serial, -- serial data turu otomatik olarak 1'den baslayarak sirali olarak sayi atamasi yapar.
	       -- INSERT INTO ile tabloya veri eklerken serial data turunu kullandigim veri degeri yerine default yazariz.
	       -- otomatik siraya sokuyor serial (id 1,2,3... default yazdigimiz icin)
	       -- serial transcaktion yapisinda pek kullanilmasi onerilmez. cunku siralama silindigi zaman (3,4) tekrar eklendiginde (5,6) yazar.
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);



BEGIN;
INSERT INTO ogrenciler13 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler13 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler13 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler13 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler13 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler13 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to y;
COMMIT;

SELECT * FROM ogrenciler13;

DELETE from ogrenciler13;

DROP TABLE ogrenciler13;


/*
	Transaction kullaniminda SERIAL data turu kullanimi tercih edilmez. Save pointten sonra ekledigimiz
	veride sayac mantigi ile calistigi icin sayacta en son hangi sayida kaldiysa ordan devam eder.
	NOT :PostgreSQL de Transaction kullanımı için «Begin;» komutuyla başlarız sonrasında tekrar
	yanlış bir veriyi düzelmek veya bizim için önemli olan verilerden
	sonra ekleme yapabilmek için "SAVEPOINT savepointismi" komutunu
	kullanırız ve bu savepointe dönebilmek için "ROLLBACK TO savepointismi" komutunu
	kullanırız ve rollback çalıştırıldığında savepoint yazdığımız satırın üstündeki
	verileri tabloda bize verir ve son olarak Transaction'ı sonlandırmak için mutlaka
	"COMMIT" komutu kullanılır.
 */





