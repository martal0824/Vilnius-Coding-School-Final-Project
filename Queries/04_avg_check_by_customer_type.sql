-- Calculates the average check amount and number of transactions by customer type.
-- Helps compare spending behavior across loyal, new, casual, or unassigned customers.

SELECT COALESCE(kt.pavadinimas, 'Nepriskirtas') AS klientu_tipas,
ROUND(AVG(p.suma_eur), 2) AS vid_cekio_suma,
COUNT(*) AS cekiu_sk
FROM pardavimai AS p
JOIN apsilankymai AS a 
ON a.id_apsilankymai = p.apsilankymai_id
LEFT JOIN klientai AS k 
ON k.id_klientai = a.klientai_id
LEFT JOIN klientu_tipai AS kt 
ON kt.id_klientu_tipai = k.klientu_tipai_id
GROUP BY COALESCE(kt.pavadinimas, 'Nepriskirtas')
ORDER BY vid_cekio_suma DESC;