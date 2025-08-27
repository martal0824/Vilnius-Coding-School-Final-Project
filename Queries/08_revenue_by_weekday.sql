-- Aggregates sales by day of the week, showing total revenue and number of checks.
-- Helps identify which weekdays are the most profitable for the restaurant.
SELECT DAYNAME(p.data_laikas) AS savaites_diena,
SUM(p.suma_eur) AS pardavimai_eur,
COUNT(*) AS cekių_sk
FROM pardavimai AS p
GROUP BY DAYNAME(p.data_laikas)
ORDER BY pardavimai_eur DESC;