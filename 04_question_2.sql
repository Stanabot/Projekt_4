-- Food Units Purchasable for Average Czech Salary (Bread & Milk)

WITH cz_summary AS (
	SELECT 
		"year",
		product_name,
		ROUND(AVG(avg_salary), 2) AS cz_avg_salary,
		ROUND(AVG(avg_price), 2) AS avg_price
	FROM t_stanislava_jahodova_project_SQL_primary_final
	WHERE 
		"year" IN (2006, 2018)
		AND product_name IN (
			'Mléko polotučné pasterované',
			'Chléb konzumní kmínový'
		)
	GROUP BY
		"year", 
		product_name
),
units_pivot AS (
    SELECT
        product_name,
        MAX(
        	CASE
	        	WHEN year = 2006 THEN cz_avg_salary / avg_price
	        END
	    ) AS units_in_2006,
        MAX(
        	CASE
	        	WHEN year = 2018 THEN cz_avg_salary / avg_price
	        END
	    ) AS units_in_2018
    FROM cz_summary
    GROUP BY product_name
)
SELECT
    product_name,
    ROUND(units_in_2006, 2) AS units_in_2006,
    ROUND(units_in_2018, 2) AS units_in_2018,
    ROUND(units_in_2018 - units_in_2006, 2) AS diff
FROM units_pivot
ORDER BY product_name;

---

-- Food Purchasing Power in Best and Worst Paid Industries (Bread & Milk)

WITH food_data AS (
    SELECT 
        year,
        industry_name,
        avg_salary,
        product_name,
        avg_price,
        ROUND(avg_salary / avg_price, 2) AS purchasable_units,
        RANK() OVER (
        	PARTITION BY year, product_name ORDER BY avg_salary DESC
        ) AS salary_rank_desc,
        RANK() OVER (
        	PARTITION BY year, product_name ORDER BY avg_salary ASC
        ) AS salary_rank_asc
    FROM t_stanislava_jahodova_project_SQL_primary_final
    WHERE 
        year IN (2006, 2018)
        AND product_name IN (
            'Chléb konzumní kmínový',
            'Mléko polotučné pasterované'
        )
)
SELECT 
    year,
    industry_name,
    avg_salary,
    product_name,
    avg_price,
    purchasable_units
FROM food_data
WHERE 
	salary_rank_desc = 1
	OR salary_rank_asc = 1
ORDER BY
	product_name,
	year,
	avg_salary DESC;


