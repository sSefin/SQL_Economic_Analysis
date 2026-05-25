SELECT 
unemployment_rate.country_name,
unemployment_rate.year,
CASE
    WHEN gini_coefficient.gini_coefficient >= 35 THEN 'High'
    ELSE 'Low'
END AS economic_inequality,
ROUND(unemployment_rate.unemployment_rate, 2) AS unemployment_rate,
quality_of_life.qol
FROM unemployment_rate
LEFT JOIN quality_of_life
ON unemployment_rate.country_name = quality_of_life.country_name 
AND unemployment_rate.year = quality_of_life.year
LEFT JOIN gini_coefficient 
ON unemployment_rate.country_name = gini_coefficient.country_name
ORDER BY country_name, year;