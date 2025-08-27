-- Splits sales into time-of-day segments (lunch, dinner, or other) using CASE.
-- Shows number of checks, average check value, and total revenue per segment.
SELECT 
CASE
WHEN TIME(data_laikas) BETWEEN '11:00:00' AND '15:00:00' THEN 'Pietūs'
WHEN TIME(data_laikas) BETWEEN '17:00:00' AND '22:00:00' THEN 'Vakarienė'
ELSE 'Kitas laikas'
END AS dienos_metas,
COUNT(*) AS cekiu_sk,
ROUND(AVG(suma_eur), 2) AS vid_cekio_suma,
SUM(suma_eur) AS pajamos
FROM pardavimai 
GROUP BY 
CASE
WHEN TIME(data_laikas) BETWEEN '11:00:00' AND '15:00:00' THEN 'Pietūs'
WHEN TIME(data_laikas) BETWEEN '17:00:00' AND '22:00:00' THEN 'Vakarienė'
ELSE 'Kitas laikas'
END
ORDER BY pajamos DESC;