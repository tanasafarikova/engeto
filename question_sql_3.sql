-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

SELECT category,
	round(SUM(pct), 2) AS change_in_percent
FROM (
	SELECT 
		YEAR,
		category,
		avg_price,
		lag(avg_price) OVER (PARTITION BY category ORDER BY category, YEAR ) AS previous_year,
		avg_price / lag(avg_price) OVER (PARTITION BY category ORDER BY category, YEAR ) *100-100 AS pct
	FROM t_tana_safarikova_project_sql_primary_final ttspspf 
	WHERE avg_price IS NOT NULL
	ORDER BY 	
		category ,
		YEAR
) DATA
GROUP BY category
ORDER BY 
	change_in_percent
	
-- nejpomaleji zdrazuje cukr, protoze zlevnuje

