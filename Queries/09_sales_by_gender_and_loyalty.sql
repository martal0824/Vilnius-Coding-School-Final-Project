-- Breaks down sales by gender and loyalty status, showing number of checks,
-- total revenue, and average check. Useful for analyzing customer segments.
SELECT
IF(k.lytis = 'V', 'Vyras', 'Moteris') AS lytis,
IF(k.unikalus_kodas IS NULL, 'ne_lojalus', 'lojalus') AS lojalumas,
COUNT(p.id_pardavimai) AS cekiu_kiekis,
SUM(p.suma_eur) AS bendra_apyvarta,
ROUND(AVG(p.suma_eur), 2) AS vidutinis_cekis
FROM pardavimai AS p
JOIN apsilankymai AS a
ON a.id_apsilankymai = p.apsilankymai_id
JOIN klientai AS k
ON k.id_klientai = a.klientai_id
WHERE k.lytis IN ('V','M') 
GROUP BY lytis, lojalumas
ORDER BY bendra_apyvarta DESC;