-- Years with Significantly Higher Growth in Food Prices Than in Wages (Δ > 10%)

WITH yearly_avg AS (
    SELECT
        year,
        ROUND(AVG(avg_salary), 2) AS avg_salary,
        ROUND(AVG(avg_price), 2) AS avg_price
    FROM t_stanislava_jahodova_project_SQL_primary_final
    GROUP BY year
    ORDER BY year
),
pct_growth AS (
    SELECT
        year,
        ROUND(
            (avg_salary - LAG(avg_salary) OVER (ORDER BY year)) 
            / NULLIF(LAG(avg_salary) OVER (ORDER BY year), 0) 
            * 100, 
            2
        ) AS salary_growth_pct,
        ROUND(
            (avg_price - LAG(avg_price) OVER (ORDER BY year)) 
            / NULLIF(LAG(avg_price) OVER (ORDER BY year), 0) 
            * 100, 
            2
        ) AS price_growth_pct
    FROM
        yearly_avg
)
SELECT
    year,
    salary_growth_pct,
    price_growth_pct,
    ROUND(
    	price_growth_pct - salary_growth_pct,
    	2
    	) AS growth_difference_pct
FROM
    pct_growth
WHERE salary_growth_pct IS NOT NULL
  AND price_growth_pct IS NOT NULL
ORDER BY
    growth_difference_pct ASC;
