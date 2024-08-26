/* Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji
v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem? */


SELECT 
	prices.YEAR,
	avg(avg_price) / lag(avg(avg_price)) OVER (ORDER BY YEAR ) *100-100 AS prices_pct,
	wages.pct AS wages_pct,
	gdp.GDP / lag(gdp.GDP,1) OVER (ORDER BY YEAR ) *100-100 gdp_pct
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
JOIN t_tana_safarikova_project_sql_secondary_final gdp ON gdp.year = prices.year
WHERE avg_price IS NOT NULL 
GROUP BY 
	prices.YEAR

-- K vetsimu propadu rustu doslo v roce 2009, kde by pokles HDP o 4,7% což se projevilo ve stejném roce i na poklesu cen potravin. Zároveň se snížil růst mezd.