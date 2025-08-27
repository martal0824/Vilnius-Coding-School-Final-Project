-- Retrieves the top customers by number of visits and total spending.
-- Uses COALESCE to include unidentified visitors and COUNT DISTINCT for unique visits.
SELECT
COALESCE(k.vardas_pavarde, 'Neidentifikuotas') AS klientas,
COUNT(DISTINCT a.id_apsilankymai) AS apsilankymu_sk,
SUM(p.suma_eur) AS bendra_suma
FROM apsilankymai AS a
LEFT JOIN klientai AS k 
ON k.id_klientai = a.klientai_id
LEFT JOIN pardavimai AS p 
ON p.apsilankymai_id = a.id_apsilankymai
GROUP BY
COALESCE(k.vardas_pavarde, 'Neidentifikuotas')
ORDER BY apsilankymu_sk DESC, bendra_suma DESC
LIMIT 12;
