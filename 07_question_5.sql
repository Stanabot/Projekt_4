 -- GDP Growth vs. Changes in Wages and Food Prices (2007–2018)

WITH cte_summary AS (
    SELECT
        t.year,
        ROUND(AVG(t.avg_salary), 2) AS avg_salary,
        ROUND(AVG(t.avg_price), 2) AS avg_price,
        ROUND(AVG(cz_gdp)::numeric, 2) AS gdp
    FROM t_stanislava_jahodova_project_SQL_primary_final t
    GROUP BY t.year
),
growth_comparison AS (
    SELECT
        year,
        avg_salary,
        avg_price,
        gdp,
        ROUND(
            (avg_salary - LAG(avg_salary) OVER (ORDER BY year)) 
            / NULLIF(LAG(avg_salary) OVER (ORDER BY year), 0) * 100,
            2
        ) AS salary_growth_pct,
        ROUND(
            (avg_price - LAG(avg_price) OVER (ORDER BY year)) 
            / NULLIF(LAG(avg_price) OVER (ORDER BY year), 0) * 100,
            2
        ) AS price_growth_pct,
        ROUND(
            (gdp - LAG(gdp) OVER (ORDER BY year)) 
            / NULLIF(LAG(gdp) OVER (ORDER BY year), 0) * 100,
            2
        ) AS gdp_growth_pct
    FROM cte_summary
)
SELECT 
    year,
    gdp_growth_pct,
    salary_growth_pct,
    price_growth_pct
FROM growth_comparison
WHERE gdp_growth_pct IS NOT NULL
ORDER BY year;