WITH country_development AS 
(
SELECT
        gross_domestic_product.country_name AS country,
        gross_domestic_product.year AS year,
        gross_domestic_product.gdp AS gdp,
        human_development_index.hdi AS hdi,
        quality_of_life.qol AS qol,
        unemployment_rate.unemployment_rate AS unemployment_rate
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



annual_cpi AS 
(
    SELECT 
        consumer_price_index.country_name,
        consumer_price_index.year,
        AVG(consumer_price_index.cpi) AS yearly_cpi
    FROM consumer_price_index
    GROUP BY country_name, year
),




economic_equality AS
(
SELECT 
        annual_cpi.country_name AS country,
        annual_cpi.year AS year,
        ROUND(annual_cpi.yearly_cpi, 2) AS yearly_cpi,
        LAG(annual_cpi.yearly_cpi, 1) OVER (PARTITION BY annual_cpi.country_name ORDER BY annual_cpi.year) AS previous_cpi,
        gini_coefficient.gini_coefficient AS gini_value
FROM 
        annual_cpi
LEFT JOIN 
        gini_coefficient 
        ON annual_cpi.country_name = gini_coefficient.country_name
        AND annual_cpi.year = gini_coefficient.survey_year
ORDER BY annual_cpi.country_name, annual_cpi.year ASC
),




inflation AS 
(SELECT 
        economic_equality.country,
        economic_equality.year,
        ROUND((economic_equality.yearly_cpi - economic_equality.previous_cpi)/economic_equality.previous_cpi * 100, 2) AS inflation_rate
FROM 
        economic_equality
ORDER BY economic_equality.country, economic_equality.year ASC
),





normalised AS
(
SELECT 
        country_development.country AS country,
        country_development.year AS year,
        ROUND(((country_development.gdp - MIN(country_development.gdp)OVER (PARTITION BY country_development.year))/NULLIF(MAX(country_development.gdp) OVER (PARTITION BY country_development.year) - MIN(country_development.gdp) OVER (PARTITION BY country_development.year), 0)) * 100, 2) AS gdp_normalized,
        ROUND(((country_development.hdi - MIN(country_development.hdi) OVER (PARTITION BY country_development.year))/NULLIF(MAX(country_development.hdi) OVER (PARTITION BY country_development.year) - MIN(country_development.hdi) OVER (PARTITION BY country_development.year), 0)) * 100, 2) AS hdi_normalized,
        ROUND(((country_development.qol - MIN(country_development.qol) OVER (PARTITION BY country_development.year))/NULLIF(MAX(country_development.qol) OVER (PARTITION BY country_development.year) - MIN(country_development.qol) OVER (PARTITION BY country_development.year), 0)) * 100, 2) AS qol_normalized,
        ROUND(((MAX(country_development.unemployment_rate) OVER (PARTITION BY country_development.year) - country_development.unemployment_rate)/NULLIF(MAX(country_development.unemployment_rate) OVER (PARTITION BY country_development.year) - MIN(country_development.unemployment_rate) OVER (PARTITION BY country_development.year), 0)) * 100, 2) AS unemployment_normalized,
        ROUND(((MAX(inflation.inflation_rate)OVER (PARTITION BY country_development.year) - inflation.inflation_rate)/NULLIF(MAX(inflation.inflation_rate) OVER (PARTITION BY country_development.year) - MIN(inflation.inflation_rate) OVER (PARTITION BY country_development.year), 0)) * 100, 2) AS inflation_normalized,
        ROUND(((MAX(economic_equality.gini_value)OVER (PARTITION BY country_development.year) - economic_equality.gini_value)/NULLIF(MAX(economic_equality.gini_value) OVER (PARTITION BY country_development.year) - MIN(economic_equality.gini_value) OVER (PARTITION BY country_development.year), 0)) * 100, 2) AS gini_normalized
FROM 
        country_development
LEFT JOIN 
        economic_equality 
        ON country_development.country = economic_equality.country 
        AND country_development.year = economic_equality.year

LEFT JOIN
        inflation 
        ON country_development.country = inflation.country 
        AND country_development.year = inflation.year
        ORDER BY country_development.country, country_development.year ASC
)

SELECT
normalised.country,
normalised.year,
normalised.gdp_normalized,
normalised.hdi_normalized,
normalised.qol_normalized,
normalised.unemployment_normalized,
normalised.inflation_normalized,
    ROUND((normalised.gdp_normalized + normalised.hdi_normalized + normalised.qol_normalized + normalised.unemployment_normalized + normalised.inflation_normalized) / 5, 2) AS composite_score,
    RANK() OVER (
        PARTITION BY year 
        ORDER BY (normalised.gdp_normalized + normalised.hdi_normalized + normalised.qol_normalized + normalised.unemployment_normalized + normalised.inflation_normalized) / 5 DESC
    ) AS rank
FROM normalised
WHERE YEAR BETWEEN 2020 AND 2023
ORDER BY year, rank ASC;


