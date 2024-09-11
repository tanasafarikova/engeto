-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

WITH 
  wages AS (
		SELECT 
			YEAR,
			avg(avg_wages) AS avg_wage,
			avg(avg_wages) / lag(avg(avg_wages)) OVER (ORDER BY YEAR ) *100-100 AS pct
		FROM t_tana_safarikova_project_sql_primary_final  
		WHERE avg_wages IS NOT NULL 
		GROUP BY 
			year
	)
, prices AS (
		SELECT 
			YEAR,
			avg(avg_price) AS avg_price,
			avg(avg_price) / lag(avg(avg_price)) OVER (ORDER BY YEAR ) *100-100 AS pct
		FROM t_tana_safarikova_project_sql_primary_final  
		WHERE avg_price IS NOT NULL 
		GROUP BY 
			year
	)
SELECT
		prices.YEAR,
		prices.avg_price,
		prices.pct,
		wages.pct AS wages_pct,
		(prices.pct - wages.pct) AS difference,
		CASE WHEN (prices.pct - wages.pct) > 10 THEN 'YES' ELSE 'NO'
		END AS over_10_pct
FROM prices
JOIN wages ON prices.YEAR = wages.YEAR
WHERE prices.pct IS NOT NULL AND wages.pct IS NOT NULL 
-- Neni rok, ve kterem by byl meziroci narust potravin vyssi nez rust mezd
	