--GROUP BY 
CREATE TABLE personel
(
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20)
);


INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

DELETE FROM personel;

SELECT * FROM personel;

--Isme gore toplam maaslari bulun.
SELECT isim,sum(maas) FROM personel
GROUP BY isim;

--Personel tablosundaki isimleri gruplayiniz
SELECT isim FROM personel GROUP BY isim;

--Personel tablosundaki isimleri count ile yazdiriniz.
SELECT isim, COUNT(sehir)FROM personel GROUP BY isim;

--Sehre gore toplam personel sayisini bulunuz
SELECT sehir, COUNT(isim) AS calisan_sayisi FROM personel
GROUP BY sehir;

--Sirketlere gore maasi 5000 liradan fazla olan personel sayisini bulun
SELECT sirket, COUNT(*) AS calisan_sayisini_saydir FROM personel
WHERE maas>5000
GROUP BY sirket;
--HAVING KULLANIMI
/*
HAVING komutu yalnizca GROUP BY komutu ile kullanilir.
Eger gruplamadan sonra bir sart varsa havning komutu kullanilir.
WHERE kullanimi ile ayni mantikla calisir.
*/
-- 									HAVING CLAUSE
-- HAVING, AGGREGATE FUNCTION’lar ile birlikte kullanilan FILTRELEME komutudur.

SELECT * FROM personel;
--Her sirketin MIN maaslarini eger 4000'den buyukse goster
SELECT sirket, MIN(maas) FROM personel
GROUP BY sirket 
having MIN(maas)>4000;

--Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gosteren sorgu yaziniz.
SELECT isim, SUM(maas) FROM personel
GROUP BY isim
HAVING SUM(maas)>10000;

--Eger bir sehirde calisan personel sayisi 1'den coksa sehir ismini ve personel sayisini veren sorguyu yaziniz.
SELECT sehir, COUNT(isim) AS toplam_personel_sayisi FROM personel
GROUP BY sehir 
HAVING COUNT(isim)>1;

--Eger bir sehirde alinan MAX maas 5000’den dusukse sehir ismini ve MAX maasi veren sorgu yaziniz
SELECT sehir, MAX(maas)AS en_yuksek_maas FROM personel
GROUP BY sehir
HAVING MAX(maas)<5000;

--UNION KULLANIMI
--						UNION OPERATOR
-- Iki farkli sorgulamanin sonucunu birlestiren islemdir. Secilen Field SAYISI ve DATA TYPE’i
-- ayni olmalidir.


-- 1) Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan
-- sehirleri gosteren sorguyu yaziniz
SELECT isim as isim_ve_sehirler,maas
FROM personelWHERE maas>4000
UNION
SELECT sehir,maas FROM personel WHERE maas>5000;

-- 2) Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
-- bir tabloda gosteren sorgu yaziniz
SELECT isim AS isim_ve_sehir,maas FROM personel
WHERE isim='Mehmet Ozturk'
UNION
SELECT sehir, maas FROM personel
WHERE sehir='Istanbul'
ORDER BY maas DESC;





CREATE TABLE personel2
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);

INSERT INTO personel2 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel2 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel2 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel2 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel2 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel2 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel2 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

	
	
	
CREATE TABLE personel_bilgi  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int,
CONSTRAINT personel_bilgi_fk FOREIGN KEY (id) REFERENCES personel2(id)
);


INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);
	
SELECT * FROM personel2;
SELECT * FROM personel_bilgi;

-- id’si 123456789 olan personelin    Personel tablosundan sehir ve maasini, 
-- personel_bilgi  tablosundan da tel ve cocuk sayisini yazdirin
SELECT sehir AS sehir_ve_tel,maas FROM personel2 WHERE id=123456789
UNION
SELECT tel,cocuk_sayisi FROM personel_bilgi WHERE id=123456789;



--UNION ALL
/*
UNION tekrarli verileri teke dusurur ve bize o sekilde sonuc verir.
UNION ALL ise tekrarli verilerle birlikte tum sorgulari getirir.
UNION islemi 2 veya daha cok SELECT isleminin sonuc KUMELERINI birlestirmek icin kullanilir, Ayni kayit birden fazla olursa, sadece bir tanesini alir. UNION ALL ise tekrarli elemanlari, tekrar sayisinca yazar.
*/

--Personel tablosundada maasi 5000’den az olan tum isimleri ve maaslari bulunuz
SELECT isim,maas FROM personel2 WHERE maas<5000
UNION ALL  -- iki sorguyu alt alta koydu. -- tek UNION yazarsak tekrarli verileri teke dusurur
SELECT isim,maas FROM personel2 WHERE maas<5000;




--INTERSECT (kesisim) OPERATOR
/*
Farkli iki tablodaki verileri INTERSECT komutu ile getirebiliriz
iki farklı sql sorgusunun kesişim noktasını bulur
*/

--Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
SELECT id FROM personel2
WHERE sehir IN ('Istanbul','Ankara');

--Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
SELECT id FROM personel_bilgi
WHERE cocuk_sayisi IN (2,3);

--Iki sorguyu INTERSECT ile birlestirin
SELECT id FROM personel2
WHERE sehir IN ('Istanbul','Ankara')
INTERSECT
SELECT id FROM personel_bilgi
WHERE cocuk_sayisi IN (2,3);

SELECT * FROM personel2;

--Honda,Ford ve Tofas'ta calisan ortak isimde personel varsa listeleyin
SELECT isim FROM personel2 WHERE sirket='Honda'
INTERSECT
SELECT isim FROM personel2 WHERE sirket='Ford'
INTERSECT
SELECT isim FROM personel2 WHERE sirket='Tofas';



--EXCEPT( MINUS==> MYSQL ve ORACLE'da kullaniliyor) KULLANIMI
/*
Iki sorgulamada harici bir sorgulama istenirse EXCEPT komutu kullanilir.
*/

--5000’den az maas alip Honda’da calismayanlari yazdirin
SELECT isim,sirket FROM personel2 WHERE maas<5000
EXCEPT
SELECT isim,sirket FROM personel2 WHERE sirket='Honda';


