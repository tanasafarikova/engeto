

SELECT 
	YEAR,
	industry_branch_name ,
	avg_wages,
	lag(avg_wages) OVER (PARTITION BY industry_branch_name ORDER BY industry_branch_name, YEAR) AS previous_year,
	avg_wages - lag(avg_wages) OVER (PARTITION BY industry_branch_name ORDER BY industry_branch_name, YEAR) AS difference
FROM t_tana_safarikova_project_sql_primary_final 
WHERE avg_wages IS NOT NULL
ORDER BY 	
	industry_branch_name,
	YEAR;


 
