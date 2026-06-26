CREATE TABLE consumer_price_index (
    country_name VARCHAR(100),
    year INT,
    quarter VARCHAR(10),
    cpi NUMERIC
);

CREATE TABLE gini_coefficient (
    country_name VARCHAR(100),
    survey_year INT,
    gini_coefficient NUMERIC
);

CREATE TABLE gross_domestic_product (
    country_name VARCHAR(100),
    year INT,
    gdp NUMERIC
);

CREATE TABLE human_development_index (
    country_name VARCHAR(100),
    year INT,
    hdi NUMERIC
);

CREATE TABLE policy_rate (
    country_name VARCHAR(100),
    month INT,
    year INT,
    policy_rate NUMERIC
);

CREATE TABLE quality_of_life (
    country_name VARCHAR(100),
    year INT,
    qol NUMERIC
);

CREATE TABLE unemployment_rate (
    country_name VARCHAR(100),
    year INT,
    unemployment_rate NUMERIC
);