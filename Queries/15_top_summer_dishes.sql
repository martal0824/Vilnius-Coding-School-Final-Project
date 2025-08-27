-- Retrieves the Top 5 best-selling dishes during the summer season (June–August).
-- Aggregates quantity sold and total revenue to identify seasonal favorites.
SELECT 
pat.pavadinimas,
SUM(pp.kiekis) AS kiekis_vnt,
ROUND(SUM(pp.kiekis * pat.kaina), 2) AS pajamos_eur
FROM parduoti_patiekalai AS pp
JOIN patiekalai AS pat 
ON pat.id_patiekalai = pp.patiekalai_id
JOIN pardavimai AS p 
ON p.id_pardavimai = pp.pardavimai_id
WHERE p.data_laikas >= '2025-06-01' AND p.data_laikas <  '2025-09-01'
GROUP BY pat.id_patiekalai, pat.pavadinimas
ORDER BY pajamos_eur DESC
LIMIT 5; 