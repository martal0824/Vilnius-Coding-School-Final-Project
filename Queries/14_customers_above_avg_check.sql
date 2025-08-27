-- Finds customers whose average check is higher than the overall restaurant average.
-- Uses subquery for per-customer averages and CROSS JOIN for the global average,
-- highlighting premium customers who spend above average.
SELECT
t.vardas_pavarde,
ROUND(t.vidutinis_cekis, 2) AS vidutinis_cekis,
ROUND(rv.restorano_vidurkis, 2) AS restorano_vidurkis,
ROUND(t.vidutinis_cekis - rv.restorano_vidurkis, 2) AS skirtumas_eur
FROM (
SELECT 
k.id_klientai,
k.vardas_pavarde,
AVG(p.suma_eur) AS vidutinis_cekis
FROM klientai AS k
JOIN apsilankymai AS a 
ON a.klientai_id = k.id_klientai
JOIN pardavimai AS p   
ON p.apsilankymai_id = a.id_apsilankymai
GROUP BY k.id_klientai, k.vardas_pavarde
) t
CROSS JOIN (
SELECT AVG(suma_eur) AS restorano_vidurkis
FROM pardavimai
) rv
WHERE t.vidutinis_cekis > rv.restorano_vidurkis
ORDER BY skirtumas_eur DESC;