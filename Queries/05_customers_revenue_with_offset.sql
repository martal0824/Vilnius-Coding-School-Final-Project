-- Retrieves customers and their total spending, ordered by revenue.
-- Uses LIMIT + OFFSET to fetch the next Top 10 customers (e.g., ranks 11–20).
SELECT 
k.id_klientai AS klientas_id,
k.vardas_pavarde AS klientas,
SUM(p.suma_eur) AS bendra_suma
FROM pardavimai AS p
JOIN apsilankymai AS a 
ON a.id_apsilankymai = p.apsilankymai_id
JOIN klientai AS k 
ON k.id_klientai = a.klientai_id
GROUP BY k.id_klientai, k.vardas_pavarde
ORDER BY bendra_suma DESC
LIMIT 10
OFFSET 10;