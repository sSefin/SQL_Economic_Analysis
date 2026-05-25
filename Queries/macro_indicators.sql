WITH development_indicators AS 
(
SELECT
gross_domestic_product.country_name AS country,
gross_domestic_product.year AS year,
gross_domestic_product.gdp AS gdp,
human_development_index.hdi AS hdi,
quality_of_life.qol AS qol,
unemployment_rate.unemployment_rate AS unemployment_rate
FROM gross_domestic_product
LEFT JOIN human_development_index
ON gross_domestic_product.country_name = human_development_index.country_name 
AND gross_domestic_product.year = human_development_index.year
LEFT JOIN quality_of_life
ON gross_domestic_product.country_name = quality_of_life.country_name 
AND gross_domestic_product.year = quality_of_life.year
LEFT JOIN unemployment_rate
ON gross_domestic_product.country_name = unemployment_rate.country_name 
AND gross_domestic_product.year = unemployment_rate.year
WHERE gross_domestic_product.year >= 2020
ORDER BY gross_domestic_product.country_name ASC, gross_domestic_product.year ASC
)

SELECT *
FROM development_indicators