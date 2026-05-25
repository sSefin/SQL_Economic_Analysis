WITH policy_rate AS 
(
SELECT 
policy_rate.country_name,
CASE WHEN policy_rate.month = 3 THEN 'Q1'
WHEN policy_rate.month = 6 THEN 'Q2'
WHEN policy_rate.month = 9 THEN 'Q3'
WHEN policy_rate.month = 12 THEN 'Q4'
END AS quarter,
policy_rate.year,
policy_rate.policy_rate
FROM policy_rate
WHERE policy_rate.month IN (3, 6, 9, 12)
)

SELECT *
FROM policy_rate