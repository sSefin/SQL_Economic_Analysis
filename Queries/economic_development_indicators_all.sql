WITH country_development AS 
(
SELECT
        gross_domestic_product.country_name AS country,
        gross_domestic_product.year AS year,
        gross_domestic_product.gdp AS gdp,
        ROUND(human_development_index.hdi, 2) AS hdi,
        ROUND(quality_of_life.qol, 2) AS qol,
        ROUND(unemployment_rate.unemployment_rate, 2) AS unemployment_rate
FROM 
        gross_domestic_product
LEFT JOIN 
        human_development_index
        ON gross_domestic_product.country_name = human_development_index.country_name 
        AND gross_domestic_product.year = human_development_index.year
LEFT JOIN 
        quality_of_life
        ON gross_domestic_product.country_name = quality_of_life.country_name 
        AND gross_domestic_product.year = quality_of_life.year
LEFT JOIN 
        unemployment_rate
        ON gross_domestic_product.country_name = unemployment_rate.country_name 
        AND gross_domestic_product.year = unemployment_rate.year
WHERE 
    gross_domestic_product.year >= 2020
ORDER BY 
    gross_domestic_product.country_name ASC, gross_domestic_product.year ASC
),

economic_equality AS
(
SELECT 
        consumer_price_index.country_name AS country,
        consumer_price_index.year AS year,
        ROUND(AVG(consumer_price_index.cpi), 2) AS yearly_cpi,
        gini_coefficient.gini_coefficient AS gini_value
FROM 
        consumer_price_index
LEFT JOIN 
        gini_coefficient 
        ON consumer_price_index.country_name = gini_coefficient.country_name
        AND consumer_price_index.year = gini_coefficient.survey_year
GROUP BY 
    consumer_price_index.country_name, consumer_price_index.year, gini_coefficient.gini_coefficient
ORDER BY consumer_price_index.country_name, consumer_price_index.year ASC
),

annual_policy_rate AS 
(
SELECT 
        policy_rate.country_name AS country,
        ROUND(AVG(policy_rate.policy_rate), 2) AS policy_rate,
        policy_rate.year AS year
FROM 
        policy_rate
GROUP BY 
        policy_rate.country_name, policy_rate.year
ORDER BY 
        policy_rate.country_name, policy_rate.year ASC
)

SELECT 
        country_development.country,
        country_development.year,
        country_development.gdp,
        country_development.hdi,
        country_development.qol,
        country_development.unemployment_rate,
        economic_equality.yearly_cpi,
        economic_equality.gini_value,
        annual_policy_rate.policy_rate
FROM 
        country_development
LEFT JOIN 
        economic_equality 
        ON country_development.country = economic_equality.country 
        AND country_development.year = economic_equality.year
LEFT JOIN 
        annual_policy_rate 
        ON country_development.country = annual_policy_rate.country 
        AND country_development.year = annual_policy_rate.year;