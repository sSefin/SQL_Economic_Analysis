WITH cpi_q AS
(
SELECT
        consumer_price_index.country_name as country,
        CASE quarter
            WHEN '1' THEN 'Q1'
            WHEN '2' THEN 'Q2'
            WHEN '3' THEN 'Q3'
            WHEN '4' THEN 'Q4'
        END AS quarter,
        consumer_price_index.year as year,
        ROUND(consumer_price_index.cpi, 2) as cpi,
        -- 4 is used inside lag since inflation is calculated 4 quarters before (last year same quarter)
        LAG(consumer_price_index.cpi, 4) OVER (PARTITION BY consumer_price_index.country_name ORDER BY consumer_price_index.year, consumer_price_index.quarter) AS previous_cpi
FROM consumer_price_index
),

pr_q AS
(
SELECT 
        policy_rate.country_name AS country,
        CASE 
            WHEN policy_rate.month = 3 THEN 'Q1'
            WHEN policy_rate.month = 6 THEN 'Q2'
            WHEN policy_rate.month = 9 THEN 'Q3'
            WHEN policy_rate.month = 12 THEN 'Q4'
        END AS quarter,
        policy_rate.year AS year,
        policy_rate.policy_rate
FROM policy_rate
WHERE policy_rate.month IN (3, 6, 9, 12)
)

SELECT 
    cpi_q.country,
    cpi_q.year,
    cpi_q.quarter,
    cpi_q.cpi,
    -- Used formulae : current cpi - previous cpi/previous cpi * 100 to calculate change in inflation
    ROUND((cpi_q.cpi - cpi_q.previous_cpi)/cpi_q.previous_cpi * 100, 2) AS inflation_rate,
    pr_q.policy_rate
FROM cpi_q
LEFT JOIN pr_q 
    ON cpi_q.country = pr_q.country 
    AND cpi_q.quarter = pr_q.quarter 
    AND cpi_q.year = pr_q.year
-- Filter query to display key inflection metrics: high inflation (>7%) or deflation (<0%)
WHERE cpi_q.year >= 2020
  AND (
    ((cpi_q.cpi - cpi_q.previous_cpi) / cpi_q.previous_cpi * 100) > 7 
    OR 
    ((cpi_q.cpi - cpi_q.previous_cpi) / cpi_q.previous_cpi * 100) < 0
  )
ORDER BY cpi_q.country, cpi_q.year, cpi_q.quarter ASC;