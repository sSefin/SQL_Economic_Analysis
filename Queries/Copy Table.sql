COPY consumer_price_index (country_name, year, quarter, cpi) 
FROM 'D:\SQL + PowerBI\SQL_Economic_Analysis\DataSets\consumer_price_index.csv' 
DELIMITER ',' CSV HEADER;

COPY consumer_price_index (country_name, year, quarter, cpi) 
FROM 'D:\SQL + PowerBI\SQL_Economic_Analysis\DataSets\cpi_japan.csv' 
DELIMITER ',' CSV HEADER;

COPY gini_coefficient (country_name, survey_year, gini_coefficient) 
FROM 'D:\SQL + PowerBI\SQL_Economic_Analysis\DataSets\gini_coefficient.csv' 
DELIMITER ',' CSV HEADER;

COPY gross_domestic_product (country_name, year, gdp) 
FROM 'D:\SQL + PowerBI\SQL_Economic_Analysis\DataSets\gross_domestic_product.csv' 
DELIMITER ',' CSV HEADER;

COPY human_development_index (country_name, year, hdi) 
FROM 'D:\SQL + PowerBI\SQL_Economic_Analysis\DataSets\human_development_index.csv' 
DELIMITER ',' CSV HEADER;

COPY policy_rate (country_name, month, year, policy_rate) 
FROM 'D:\SQL + PowerBI\SQL_Economic_Analysis\DataSets\policy_rate.csv' 
DELIMITER ',' CSV HEADER;

COPY quality_of_life (country_name, year, qol) 
FROM 'D:\SQL + PowerBI\SQL_Economic_Analysis\DataSets\quality_of_life.csv' 
DELIMITER ',' CSV HEADER;

COPY unemployment_rate (country_name, year, unemployment_rate) 
FROM 'D:\SQL + PowerBI\SQL_Economic_Analysis\DataSets\unemployment_rate_global.csv' 
DELIMITER ',' CSV HEADER;

COPY unemployment_rate (country_name, year, unemployment_rate) 
FROM 'D:\SQL + PowerBI\SQL_Economic_Analysis\DataSets\unemployment_rate_brazil.csv' 
DELIMITER ',' CSV HEADER;

COPY unemployment_rate (country_name, year, unemployment_rate) 
FROM 'D:\SQL + PowerBI\SQL_Economic_Analysis\DataSets\unemployment_rate_india.csv' 
DELIMITER ',' CSV HEADER;