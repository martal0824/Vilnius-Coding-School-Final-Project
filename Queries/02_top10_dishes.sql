-- Retrieves the Top 10 dishes ranked by total revenue generated,
-- showing which individual menu items are the most profitable.

SELECT pat.pavadinimas,
SUM(pp.kiekis * pat.kaina) AS pajamos_eur,
SUM(pp.kiekis) AS parduota_vnt
FROM parduoti_patiekalai AS pp
JOIN patiekalai AS pat 
ON pat.id_patiekalai = pp.patiekalai_id
GROUP BY pat.pavadinimas
ORDER BY pajamos_eur DESC
LIMIT 10;