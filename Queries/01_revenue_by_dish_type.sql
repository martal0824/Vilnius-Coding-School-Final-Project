-- Query shows total revenue and sold quantity per dish category,
-- helping identify which categories bring the highest turnover.
SELECT 
pt.pavadinimas AS patiekalo_tipas,
ROUND(SUM(pp.kiekis * pat.kaina), 2) AS pajamos_eur,
SUM(pp.kiekis) AS kiekis_vnt
FROM parduoti_patiekalai AS pp
JOIN patiekalai AS pat 
ON pat.id_patiekalai = pp.patiekalai_id
JOIN patiekalu_tipai AS pt 
ON pt.id_patiekalu_tipai = pat.patiekalu_tipai_id
GROUP BY pt.pavadinimas
ORDER BY pajamos_eur DESC;