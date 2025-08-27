-- Retrieves the Top 10 non-corporate customers ranked by total spending.
-- Filters out company accounts to focus only on individual customer types.
SELECT 
k.id_klientai AS klientas_id,
k.vardas_pavarde AS klientas,
kt.pavadinimas,
SUM(p.suma_eur) AS bendra_suma
FROM pardavimai AS p
JOIN apsilankymai AS a
ON a.id_apsilankymai = p.apsilankymai_id
JOIN klientai AS k
ON k.id_klientai = a.klientai_id
JOIN klientu_tipai AS kt
ON kt.id_klientu_tipai = k.klientu_tipai_id 
WHERE kt.pavadinimas IN ('Lojalus', 'Naujas', 'Atsitiktinis', 'Turistas')         
GROUP BY k.id_klientai, k.vardas_pavarde
ORDER BY bendra_suma DESC
LIMIT 10;