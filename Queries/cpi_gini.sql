SELECT 
consumer_price_index.country_name,
consumer_price_index.year,
ROUND(AVG(consumer_price_index.cpi), 2) AS yearly_cpi,
gini_coefficient.gini_coefficient AS gini_value
FROM consumer_price_index
LEFT JOIN gini_coefficient ON consumer_price_index.country_name = gini_coefficient.country_name AND 
consumer_price_index.year = gini_coefficient.survey_year
GROUP BY consumer_price_index.country_name, consumer_price_index.year, gini_coefficient.gini_coefficient
ORDER BY consumer_price_index.country_name, consumer_price_index.year ASC