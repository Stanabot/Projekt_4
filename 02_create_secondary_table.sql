CREATE TABLE t_stanislava_jahodova_project_SQL_secondary_final AS
WITH european_countries AS ( 
	SELECT country
	FROM countries 
	WHERE continent = 'Europe'
),
european_economies AS (
	SELECT DISTINCT  
		e.year,		  
		e.country,	 
		e.gdp,
		e.gini,		 
		e.population 
	FROM economies e
	JOIN european_countries ec
		ON e.country = ec.country
	WHERE 
		e.year BETWEEN 2006 AND 2018
)
SELECT *
FROM european_economies
ORDER BY 
	year,
	country;


---

-- European GINI Inequality Overview: 2006–2018 (incl. Czech Republic)

SELECT 
    country,
    ROUND(AVG(gini)::numeric, 1) AS avg_gini_2006_2018,
    MIN(gini) AS min_gini,
    MAX(gini) AS max_gini
FROM t_stanislava_jahodova_project_SQL_secondary_final
GROUP BY country
ORDER BY avg_gini_2006_2018 DESC;