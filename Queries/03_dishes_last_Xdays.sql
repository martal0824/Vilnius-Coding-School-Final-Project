-- Lists dishes and their categories with total revenue over the last X days,
-- filtering out items with less than a chosen revenue threshold (e.g. >10 EUR).
-- Useful for identifying which dishes meaningfully contribute to sales recently.

SELECT 
pt.pavadinimas AS patiekalo_tipas,
pat.pavadinimas AS patiekalas,
ROUND(SUM(pp.kiekis * pat.kaina), 2) AS pajamos_eur
FROM parduoti_patiekalai AS pp
JOIN patiekalai AS pat 
ON pat.id_patiekalai = pp.patiekalai_id
JOIN patiekalu_tipai AS pt
ON pt.id_patiekalu_tipai = pat.patiekalu_tipai_id
JOIN pardavimai AS p
ON p.id_pardavimai = pp.pardavimai_id
WHERE p.data_laikas >= CURDATE() - INTERVAL 7 DAY
GROUP BY pt.pavadinimas, pat.pavadinimas
HAVING SUM(pp.kiekis * pat.kaina) > 10
ORDER BY pajamos_eur DESC;