--JOINS

--INNER JOIN
NOT :
/*
1) Select’ten sonra tabloda gormek istediginiz sutunlari yazarken Tablo_adi.field_adi seklinde yazin
2) From’dan sonra tablo ismi yazarken 1.Tablo ismi + INNER JOIN + 2.Tablo ismi yazmaliyiz
3) Join’i hangi kurala gore yapacaginizi belirtmelisiniz. Bunun icin ON+ kuralimiz yazilmali
*/
CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);

INSERT INTO sirketler VALUES(100, 'Toyota');
INSERT INTO sirketler VALUES(101, 'Honda');
INSERT INTO sirketler VALUES(102, 'Ford');
INSERT INTO sirketler VALUES(103, 'Hyundai');


CREATE TABLE siparisler  (
siparis_id int,  sirket_id int,  siparis_tarihi date
);

INSERT INTO siparisler VALUES(11, 101, '2020-04-17');
INSERT INTO siparisler VALUES(22, 102, ' 2020-04-18');
INSERT INTO siparisler VALUES(33, 103, ' 2020-04-19');
INSERT INTO siparisler VALUES(44, 104, ' 2020-04-20');
INSERT INTO siparisler VALUES(55,  105, ' 2020-04-21');

SELECT * FROM sirketler;
SELECT * FROM siparisler;

--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler INNER JOIN siparisler 
ON  sirketler.sirket_id=siparisler.sirket_id;



--LEFT JOIN 


--Iki tabloda sirket_id'si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun.
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler LEFT JOIN siparisler 
ON sirketler.sirket_id=siparisler.sirket_id;
--Kesisim yoksa hep null verir.




--RIGHT JOIN


--Iki tabloda sirket_id'si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun.
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler RIGHT JOIN siparisler 
ON sirketler.sirket_id=siparisler.sirket_id;
--Kesisim yoksa hep null verir.




--FULL JOIN
/*
	NOT :
	1) FULL Join’de iki tabloda var olan tum record’lar gosterilir.
	2) Bir tabloda olup otekinde olmayan data’lar bos kalir
*/

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler FULL JOIN siparisler 
ON sirketler.sirket_id=siparisler.sirket_id;
--Kesisim yoksa hep null verir.

DROP TABLE personel cascade --Tabloyu siler




--SELF JOIN


CREATE TABLE personel3  (
id int,
isim varchar(20),  
title varchar(60),  yonetici_id int
);


INSERT INTO personel3 VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel3 VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel3 VALUES(3, 'Ayse Gul', 'QA Lead', 4);
INSERT INTO personel3 VALUES(4, 'Fatma Can', 'CEO', 5);

SELECT * FROM personel3;

--Her personelin yanina yonetici ismini yazdiran bir tablo olusturun
SELECT p1.isim AS personel_isim,p2.isim AS yonetici_isim
FROM personel3 p1 INNER JOIN personel3 p2 -- INNER JOIN yerine JOIN yazarsaniz da olur.
ON p1.yonetici_id = p2.id



-- 								LIKE Condition
/*
	LIKE condition WHERE ile kullanilarak SELECT, INSERT, UPDATE, veya DELETE
	statement ile calisan wildcards’a(özel sembol) izin verir.. Ve bize pattern matching yapma
	imkani verir.
*/


CREATE TABLE musteriler2  (
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);


INSERT INTO musteriler2 (id, isim, gelir) VALUES (1001, 'Ali', 62000);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1002, 'Ayse', 57500);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1004, 'Fatma', 42000);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1005, 'Kasim', 44000);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1006, 'ahmet', 82000);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1007, 'erhan', 92000);


SELECT * FROM musteriler2;

/*
LIKE kullaniminda buyuk kucuk harf gozetmeksizin sonuc almak istersek ILIKE kullaniriz.
Like yerine -- sembollerini kullanabiliriz. 
Eger buyuk kucuk harf gozetmeksizin kullanmak istersek ~~* sembollerini kullaniriz.
LIKE ==> ~~ sembolunu kullanabiliriz.
ILIKE ==> ~~* sembolunu kullanabiliriz.
*/
/*
%A: Son harfin ‘A’ olduğu char.
A%: İlk harfin ‘A’ olduğu char.
%A%: Ortasında A’ya sahip olan.
*/

-- 1) % => 0 veya birden fazla karakter belirtir
-- SORU : Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM musteriler2 WHERE isim ILIKE 'A%';--LIKE den farkli olarka ILIKE tum a harflerini getirir (Buyuk A, kucuk a)

SELECT * FROM musteriler2 WHERE isim ~~* 'A%';--LIKE den farkli olarka ILIKE tum a harflerini getirir (Buyuk A, kucuk a)


--Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
SELECT isim,gelir FROM musteriler2 WHERE isim LIKE '%e'; 


SELECT * FROM musteriler2;


--Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
SELECT isim,gelir FROM musteriler2 WHERE isim LIKE '%er%';

-- 2) _=> sadece bir karakteri gosterir.
-- SORU : Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler2 WHERE isim LIKE '_atma';

--Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler2 WHERE isim LIKE '_a%';

--Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler2 WHERE isim LIKE '__s%';

--SORU: Ucuncu harfi solan ismi 4 harfli musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler2 WHERE isim LIKE '__s_';




-- REGEXP_LIKE
/*
	3) REGEXP_LIKE =>Daha karmaşık sorgular için herhangi bir kod, metin icerisinde istenilen yazi
	veya kod parcasinin aranip bulunmasini saglayan kendine ait soz dizimi olan bir yapidir.
	(REGEXP_LIKE) PostgreSQL de ‘’ ~ ‘’ karekteri ile kullanilir

  ^ baslayanlarda bu gosterilir
  $ bitenlerde bu gosterilir
*/

CREATE TABLE kelimeler  (
id int UNIQUE,
kelime varchar(50) NOT NULL,  Harf_sayisi int
);

INSERT INTO kelimeler VALUES (1001, 'hot', 3);
INSERT INTO kelimeler VALUES (1002, 'hat', 3);
INSERT INTO kelimeler VALUES (1003, 'hit', 3);
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
INSERT INTO kelimeler VALUES (1008, 'hct', 3);
INSERT INTO kelimeler VALUES (1005, 'adem', 4);
INSERT INTO kelimeler VALUES (1006, 'selim', 5);
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);
INSERT INTO kelimeler VALUES (1009, 'hAt', 5);

SELECT * FROM kelimeler;

--SORU : Ilk harfi h, son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdiran
--       QUERY yazin
--   ~ isareti
SELECT * FROM kelimeler WHERE kelime ~* 'h[ai]t'; --    ~* yerine SIMILAR TO ' da kullanilabilir.
-- * sembolu buyuk kucuk harf gozetmeksizin hepsini getirir

--SORU : Ilk harfi h, son harfi t olup 2. harfi a ile k arasinda olan 3 harfli kelimelerin tum bilgilerini yazdiran
--       QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~ 'h[a-k]t';

--^ baslayanlarda bu gosterilir
--$ bitenlerde bu gosterilir

--SORU : a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~ '^[as]'; /*    a-s arasindakiler demek8  */

--SORU : m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~* '[MF]$';

/*
							LIKE Condition
LIKE: Sorgulama yaparken belirli patternleri(KAlıp ifadelerle sorgu) kullanabilmezi sağlar
ILIKE: Sorgulama yaparken büyük/küçük harfe duyarsız olarak eşleştirir.
LIKE = ~~
ILIKE = ~~*
NOT LIKE = !~~
NOT ILIKE = !~~*
NOT REGEXP_LIKE = !~*
NOT REGEXP_LIKE = !~
 */

--SORU 1	:	ilk harfi h olmayan kelimelerin tum bilgilerini yazdiran QUERY	yazin
--1.YOL
SELECT * FROM kelimeler WHERE kelime NOT LIKE 'h%';

SELECT * FROM kelimeler WHERE kelime !~~ 'h%';




/*
UPPER – LOWER - INITCAP
Tablolari yazdirirken buyuk harf, kucuk harf veya ilk harfleri buyuk digerleri
kucuk harf yazdirmak icin kullaniriz
 */
 
 SELECT * FROM kelimeler;

 --Kelimeler tablosundaki kelime sutunundaki verileri once hepsini buyuk harf
 --sonra kucuk harf ve ilk harleri buyuk harf olacak sekilde yazdiralim
SELECT UPPER(kelime) AS kelime FROM kelimeler; --Hepsini buyuk harf yapar

SELECT LOWER(kelime) AS kelime FROM kelimeler;-- Hepsini kucuk harf yapar

SELECT INITCAP(kelime) AS kelime FROM kelimeler; --INITCAP istedigimiz sutundaki verilerin ilk harfini buyuk yazar.

--Musterler tablosundan butun isimleri buyuk harf yapiniz.
SELECT UPPER(isim) FROM musteriler2;

--Musterler tablosundan butun isimleri kucuk harf yapiniz.
SELECT LOWER(isim) FROM musteriler2;

SELECT LOWER(isim),UPPER(isim) FROM personel3; --Birden fazla sutunu kullanabiliriz.
/*
Eger birden fazla sutundaki verileri buyuk kucuk harf yapmak istersek
SELECT LOWER(isim),UPPER(isim) FROM personel3;
yapabilirz
*/


