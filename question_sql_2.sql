

/*SELECT 
	YEAR,
	category ,
	avg_price,
	avg_wages 
FROM t_tana_safarikova_project_sql_primary_final prices
WHERE 
	category = 'Mléko polotučné pasterované' 
	OR category = 'Chléb konzumní kmínový'
ORDER BY 
	category,
	YEAR;
*/ -- priprava na filtraci zbozi


SELECT 
	wages.YEAR,
	avg(wages.avg_wages) AS avg_wages,
	prices.category AS category,
	prices.avg_price AS prices,
	round(avg(wages.avg_wages) /prices.avg_price) AS units_per_wage
FROM t_tana_safarikova_project_sql_primary_final wages
JOIN t_tana_safarikova_project_sql_primary_final prices
	ON prices.YEAR = wages.YEAR 
	AND (prices.category = 'Mléko polotučné pasterované' OR prices.category = 'Chléb konzumní kmínový')
WHERE wages.avg_wages IS NOT NULL
GROUP BY 
	wages.YEAR,
	prices.category 
	
