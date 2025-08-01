CREATE TABLE t_stanislava_jahodova_project_SQL_primary_final AS
WITH avg_salaries AS (
    SELECT
        cpay.payroll_year AS year,
        cpib."name" AS industry_name,
        ROUND(AVG(cpay.value)::NUMERIC, 2) AS avg_salary
    FROM czechia_payroll cpay
    JOIN czechia_payroll_industry_branch cpib
        ON cpay.industry_branch_code = cpib.code
    WHERE 
        cpay.value_type_code = 5958
        AND cpay.calculation_code = 200
        AND cpay.payroll_year BETWEEN 2006 AND 2018
    GROUP BY 
        cpay.payroll_year,
        cpib."name"
),
avg_food_prices AS (
    SELECT
        DATE_PART('year', cp.date_from) AS year,
        cpc.name AS product_name,
        ROUND(AVG(cp.value)::numeric, 2) AS avg_price
    FROM czechia_price cp
    JOIN czechia_price_category cpc
        ON cp.category_code = cpc.code
    WHERE 
        cp.region_code IS NULL
        AND DATE_PART('year', cp.date_from) BETWEEN 2006 AND 2018
    GROUP BY 
        DATE_PART('year', cp.date_from),
        cpc.name
),
cz_gdp AS (
	SELECT DISTINCT
		year,
		MAX(e.gdp) AS cz_gdp
	FROM economies AS e
	WHERE e.country = 'Czech Republic'
	AND e.year BETWEEN 2006 AND 2018
	GROUP BY e.year
)
SELECT
    s.year,
    s.industry_name,
    s.avg_salary,
    f.product_name,
    f.avg_price,
    g.cz_gdp
FROM avg_salaries AS s
JOIN avg_food_prices AS f
    ON s.year = f.year
JOIN cz_gdp AS g
    ON s.year = g.year
ORDER BY
    s.year,
    s.industry_name,
    f.product_name;

