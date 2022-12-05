--ODEV
-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz
SELECT * FROM markalar;
SELECT * FROM calisanlar2;

SELECT marka_id AS ankaradacalisanid,calisan_sayisi FROM markalar
WHERE marka_isim IN (SELECT isyeri FROM calisanlar2 WHERE sehir='Ankara');
