-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

	
SELECT 
	prices.YEAR,
	avg(avg_price) AS avg_price,
	avg(avg_price) / lag(avg(avg_price)) OVER (ORDER BY YEAR ) *100-100 AS prices_pct,
	wages.pct AS wages_pct,
	CASE WHEN ((avg(avg_price) / lag(avg(avg_price)) OVER (ORDER BY YEAR ) *100-100) - wages.pct) > 10 THEN 'YES' ELSE 'NO'
	END AS difference
FROM t_tana_safarikova_project_sql_primary_final prices 
JOIN (
	SELECT 
		YEAR,
		avg(avg_wages) AS avg_wage,
		avg(avg_wages) / lag(avg(avg_wages)) OVER (ORDER BY YEAR ) *100-100 AS pct
	FROM t_tana_safarikova_project_sql_primary_final  
	WHERE avg_wages IS NOT NULL 
	GROUP BY 
		year
) wages
ON prices.YEAR = wages.year 
WHERE avg_price IS NOT NULL 
GROUP BY 
	prices.YEAR
	
-- Neni rok, ve kterem by byl meziroci narust potravin vyssi nez rust mezd
	