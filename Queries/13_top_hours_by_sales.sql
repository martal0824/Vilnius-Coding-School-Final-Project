-- Analyzes sales by hour of the day, showing top 5 hours by revenue.
-- Includes HAVING to filter out hours with fewer than 5 checks.
SELECT
HOUR(data_laikas) AS valanda,
COUNT(*) AS cekiu_kiekis,
SUM(suma_eur) AS apyvarta,
ROUND(AVG(suma_eur), 2) AS vidutinis_cekis
FROM pardavimai
GROUP BY HOUR(data_laikas)
HAVING COUNT(*) > 5
ORDER BY apyvarta DESC
LIMIT 5;  