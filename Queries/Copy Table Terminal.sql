\copy consumer_price_index (country_name, year, quarter, cpi) FROM '/Users/sefin/Desktop/SQL/Project/DataSets/consumer_price_index.csv' DELIMITER ',' CSV HEADER;

\copy gini_coefficient (country_name, survey_year, gini_coefficient) FROM '/Users/sefin/Desktop/SQL/Project/DataSets/gini_coefficient.csv' DELIMITER ',' CSV HEADER;

\copy gross_domestic_product (country_name, year, gdp) FROM '/Users/sefin/Desktop/SQL/Project/DataSets/gross_domestic_product.csv' DELIMITER ',' CSV HEADER;

\copy human_development_index (country_name, year, hdi) FROM '/Users/sefin/Desktop/SQL/Project/DataSets/human_development_index.csv' DELIMITER ',' CSV HEADER;

\copy policy_rate (country_name, month, year, policy_rate) FROM '/Users/sefin/Desktop/SQL/Project/DataSets/policy_rate.csv' DELIMITER ',' CSV HEADER;

\copy quality_of_life (country_name, year, qol) FROM '/Users/sefin/Desktop/SQL/Project/DataSets/quality_of_life.csv' DELIMITER ',' CSV HEADER;

\copy unemployment_rate (country_name, year, unemployment_rate) FROM '/Users/sefin/Desktop/SQL/Project/DataSets/unemployment_rate_global.csv' DELIMITER ',' CSV HEADER;

\copy unemployment_rate (country_name, year, unemployment_rate) FROM '/Users/sefin/Desktop/SQL/Project/DataSets/unemployment_rate_brazil.csv' DELIMITER ',' CSV HEADER;

\copy unemployment_rate (country_name, year, unemployment_rate) FROM '/Users/sefin/Desktop/SQL/Project/DataSets/unemployment_rate_india.csv' DELIMITER ',' CSV HEADER;