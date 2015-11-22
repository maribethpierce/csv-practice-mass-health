-- DEFINE YOUR DATABASE SCHEMA HERE
DROP TABLE IF EXISTS healthcare, geography, population, income, poverty, prenatal_care;

CREATE TABLE healthcare (
  id SERIAL PRIMARY KEY,
  geography_id varchar(255),
  population_id varchar(255),
  income_id varchar(255),
  poverty_id varchar(255),
  prenatal_care_id varchar(255)
);

CREATE TABLE geography (
  id SERIAL PRIMARY KEY,
  town_name varchar(50) NOT NULL
);

CREATE TABLE population (
  id SERIAL PRIMARY KEY,
  total_pop integer,
  youth_pop integer,
  elder_pop integer
);

CREATE TABLE income (
    id SERIAL PRIMARY KEY,
    per_cap_income Money
);

CREATE TABLE poverty (
  id SERIAL PRIMARY KEY,
  num NUMERIC,
  percentage NUMERIC
);

CREATE TABLE prenatal_care (
  id SERIAL PRIMARY KEY,
  adequacy NUMERIC,
  c_section NUMERIC,
  inf_death NUMERIC,
  inf_mort NUMERIC,
  low_birthwt NUMERIC,
  multi_birth NUMERIC,
  public_financ NUMERIC,
  teen_birth NUMERIC
);
