

-- data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky
CREATE TABLE t_tana_safarikova_project_SQL_primary_final AS
SELECT 
	 year(cp.date_from) AS YEAR,
	 cpc.name AS category,
	 round(avg(cp.value), 2) AS avg_price,
	 NULL industry_branch_name,
	 NULL avg_wages
FROM czechia_price cp
JOIN czechia_price_category cpc 
ON cp.category_code = cpc.code 
WHERE cp.region_code IS NULL
GROUP BY 
	YEAR,
	cpc.name
UNION ALL 	
SELECT 
	cp.payroll_year ,
	NULL category,
	NULL avg_price,
	branch.name AS industry_branch_name,
	round(avg(cp.value), 2) AS avg_wages
FROM czechia_payroll cp 
JOIN czechia_payroll_value_type vtype 
ON cp.value_type_code = vtype.code 
JOIN czechia_payroll_industry_branch branch 
ON cp.industry_branch_code = branch.code 
WHERE vtype.name  = 'Průměrná hrubá mzda na zaměstnance'
GROUP BY 
	cp.payroll_year,
	industry_branch_name;