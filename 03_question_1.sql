--1. Industry Salary Growth and Rankings by Year (2006–2018)

WITH salary_base AS (
	SELECT DISTINCT
        industry_name,
        year,
        avg_salary
    FROM t_stanislava_jahodova_project_SQL_primary_final
	ORDER BY "year"  	
),
ranked_salaries_lag AS(
	SELECT 
        industry_name,
        year,
        avg_salary,
        LAG(avg_salary) OVER (
        	PARTITION BY industry_name ORDER BY YEAR
        ) AS prev_salary,
        RANK() OVER (
        	PARTITION BY year ORDER BY avg_salary DESC
        ) AS rank_current
    FROM salary_base
 	ORDER BY "year"
 ),
 ranked_prev_salaries AS (
	SELECT 
		industry_name,
        year,
        avg_salary,
        rank_current,
        prev_salary,
        RANK() OVER (
        	PARTITION BY year ORDER BY prev_salary DESC
        ) AS rank_prev        
	FROM ranked_salaries_lag
	WHERE prev_salary IS NOT NULL
)
SELECT 
	industry_name,
    year,
    avg_salary,
    rank_current,
    prev_salary,
    rank_prev,
	ROUND(
		(avg_salary - prev_salary) / prev_salary * 100,
		2
	) AS salary_growth_pct
FROM ranked_prev_salaries
WHERE prev_salary IS NOT NULL
ORDER BY 
	"year",
	rank_current,
	industry_name;
        
 ---
 
 -- 2. Yearly Average Salary Growth Across Industries (2006–2018)

WITH salary_base AS (
	SELECT DISTINCT
        industry_name,
        year,
        avg_salary
    FROM t_stanislava_jahodova_project_SQL_primary_final
),
ranked_salaries_lag AS (
	SELECT 
        industry_name,
        year,
        avg_salary,
        LAG(avg_salary) OVER (
        	PARTITION BY industry_name ORDER BY YEAR
        ) AS prev_salary
    FROM salary_base
),
growth_per_industry AS (
	SELECT 
        industry_name,
        year,
        ROUND(
        	((avg_salary - prev_salary) / prev_salary) * 100,
        	2
        ) AS salary_growth_pct
    FROM ranked_salaries_lag
    WHERE prev_salary IS NOT NULL
),
avg_growth_per_year AS (
	SELECT 
        year,
        ROUND(AVG(salary_growth_pct), 2) AS avg_growth_pct
    FROM growth_per_industry
    GROUP BY year
)
SELECT *
FROM avg_growth_per_year
ORDER BY avg_growth_pct;

---

-- 3. Jumpers in Salary Rankings 

WITH salary_base AS ( 
	SELECT DISTINCT
        industry_name,
        year,
        avg_salary
    FROM t_stanislava_jahodova_project_SQL_primary_final
    WHERE year IN (2006, 2018)
),
ranked_years AS (
	SELECT 
        industry_name,
        year,
        RANK() OVER (
        	PARTITION BY year ORDER BY avg_salary DESC
        ) AS rank_by_salary
    FROM salary_base
),
pivoted_ranks AS (
	SELECT
		industry_name,
		MAX(
			CASE WHEN year = 2006 THEN rank_by_salary END
		) AS rank_2006,
		MAX(
			CASE WHEN year = 2018 THEN rank_by_salary END
		) AS rank_2018
	FROM ranked_years
	GROUP BY industry_name
)
SELECT 
	industry_name,
    rank_2006,
    rank_2018,
    rank_2018 - rank_2006 AS rank_change
FROM pivoted_ranks
ORDER BY rank_change;
