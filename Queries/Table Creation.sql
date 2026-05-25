CREATE TABLE consumer_price_index (
    id SERIAL PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    quarter INT NOT NULL,
    cpi NUMERIC NOT NULL,
    UNIQUE (country_name, year, quarter)
);

CREATE TABLE gini_coefficient (
    id SERIAL PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL,
    survey_year INT NOT NULL,
    gini_coefficient NUMERIC NOT NULL,
    UNIQUE (country_name, survey_year)
);

CREATE TABLE gross_domestic_product (
    id SERIAL PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    gdp NUMERIC NOT NULL,
    UNIQUE (country_name, year)
);

CREATE TABLE human_development_index (
    id SERIAL PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    hdi NUMERIC NOT NULL,
    UNIQUE (country_name, year)
);

CREATE TABLE policy_rate (
    id SERIAL PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL,
    month INT NOT NULL,
    year INT NOT NULL,
    policy_rate NUMERIC NOT NULL,
    UNIQUE (country_name, month, year)
);

CREATE TABLE quality_of_life (
    id SERIAL PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    qol NUMERIC NOT NULL,
    UNIQUE (country_name, year)
);

CREATE TABLE unemployment_rate (
    id SERIAL PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    unemployment_rate NUMERIC NOT NULL,
    UNIQUE (country_name, year)
);