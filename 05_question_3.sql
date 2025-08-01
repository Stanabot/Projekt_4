-- Slowest Growing Food Categories 
-- by Average Year-over-Year Price Increase (2006–2018)

WITH lagged_prices AS (
    SELECT
        year,
        product_name,
        avg_price,
        LAG(avg_price) OVER (
            PARTITION BY product_name
            ORDER BY year
        ) AS previous_price
    FROM t_stanislava_jahodova_project_SQL_primary_final
),
pct_price_growth AS (
    SELECT
        year,
        product_name,
        avg_price,
        previous_price,
        ROUND(
            100.0 * (avg_price - previous_price)
            / NULLIF(previous_price, 0),
            2
        ) AS pct_growth
    FROM lagged_prices
    WHERE previous_price IS NOT NULL
)
SELECT
    product_name,
    ROUND(AVG(pct_growth), 2) AS avg_pct_growth
FROM pct_price_growth
GROUP BY product_name
ORDER BY avg_pct_growth
LIMIT 5;
