-- Groups customers into age ranges using CASE and aggregates their spending.
-- Shows number of checks and total revenue per age group, useful for demographic analysis.
SELECT
CASE
WHEN TIMESTAMPDIFF(YEAR, k.gimimo_data, CURDATE()) BETWEEN 18 AND 24 THEN '18-24'
WHEN TIMESTAMPDIFF(YEAR, k.gimimo_data, CURDATE()) BETWEEN 25 AND 34 THEN '25-34'
WHEN TIMESTAMPDIFF(YEAR, k.gimimo_data, CURDATE()) BETWEEN 35 AND 44 THEN '35-44'
WHEN TIMESTAMPDIFF(YEAR, k.gimimo_data, CURDATE()) BETWEEN 45 AND 54 THEN '45-54'
WHEN TIMESTAMPDIFF(YEAR, k.gimimo_data, CURDATE()) >= 55 THEN '55+'
ELSE 'nežinoma'
END AS amziaus_grupe,
COUNT(*) AS cekiu_kiekis,
ROUND(SUM(p.suma_eur), 2) AS apyvarta
FROM pardavimai AS p
JOIN apsilankymai AS a 
ON a.id_apsilankymai = p.apsilankymai_id
LEFT JOIN klientai AS k 
ON k.id_klientai = a.klientai_id
GROUP BY amziaus_grupe
ORDER BY apyvarta DESC;