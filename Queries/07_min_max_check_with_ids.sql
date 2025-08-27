-- Calculates the average, minimum, and maximum check values within a given period.
-- Subqueries return the IDs of the transactions with the smallest and largest checks.
SELECT
ROUND(AVG(suma_eur), 2) AS vid_cekis,
MIN(suma_eur) AS min_cekis,
(SELECT id_pardavimai 
FROM pardavimai 
WHERE data_laikas >= CURDATE() - INTERVAL 30 DAY
ORDER BY suma_eur ASC 
LIMIT 1) AS min_cekio_id,
MAX(suma_eur) AS max_cekis,
(SELECT id_pardavimai 
FROM pardavimai 
WHERE data_laikas >= CURDATE() - INTERVAL 30 DAY
ORDER BY suma_eur DESC 
LIMIT 1) AS max_cekio_id
FROM pardavimai
WHERE data_laikas >= CURDATE() - INTERVAL 30 DAY;