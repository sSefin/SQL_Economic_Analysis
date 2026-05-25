WITH annual_policy_rate AS 
(
SELECT 
policy_rate.country_name,
ROUND(AVG(policy_rate.policy_rate), 2) AS policy_rate,
policy_rate.year
FROM policy_rate
GROUP BY policy_rate.country_name, policy_rate.year
ORDER BY policy_rate.country_name, policy_rate.year ASC
)
SELECT *
FROM annual_policy_rate