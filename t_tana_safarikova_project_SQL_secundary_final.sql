

CREATE TABLE t_tana_safarikova_project_SQL_secondary_final AS
SELECT 
	year, 
	country, 
	GDP
FROM economies 
WHERE (country = 'Czech Republic') 
	AND (GDP IS NOT NULL)