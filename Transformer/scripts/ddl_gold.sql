-- SCHEMA GOLD
CREATE SCHEMA IF NOT EXISTS gold;

-- DIM CLIENT
CREATE TABLE dw.dim_client (
  sk_client SERIAL PRIMARY KEY,
  client_id INT,
  gender VARCHAR(10),
  current_age SMALLINT,
  birth_year SMALLINT,
  birth_month SMALLINT,
  per_capita_income FLOAT,
  yearly_income FLOAT,
  total_debt FLOAT,
  credit_score SMALLINT
);

-- DIM TIME
CREATE TABLE dw.dim_time (
  sk_time SERIAL PRIMARY KEY,
  date DATE,
  year SMALLINT,
  quarter SMALLINT,
  month SMALLINT,
  day SMALLINT
);

-- DIM CARDS
CREATE TABLE dw.dim_cards (
  sk_card SERIAL PRIMARY KEY,
  card_id INT,
  card_brand VARCHAR(50),
  card_type VARCHAR(50),
  has_chip VARCHAR(10),
  credit_limit FLOAT,
  acct_open_date DATE,
  card_on_dark_web VARCHAR(5),
  num_cards_issued SMALLINT
);

-- DIM MERCHANT
CREATE TABLE dw.dim_merchant (
  sk_merchant SERIAL PRIMARY KEY,
  merchant_id VARCHAR(50),
  merchant_city VARCHAR(100),
  merchant_state VARCHAR(50),
  zip INT,
  mcc INT,
  mcc_description VARCHAR(255)
);

-- FACT TRANSACTIONS
CREATE TABLE dw.fact_transactions (
  sk_transaction SERIAL PRIMARY KEY,
  fk_client INT REFERENCES dw.dim_client(sk_client),
  fk_time INT REFERENCES dw.dim_time(sk_time),
  fk_card INT REFERENCES dw.dim_cards(sk_card),
  fk_merchant INT REFERENCES dw.dim_merchant(sk_merchant),
  amount FLOAT,
  use_chip VARCHAR(10),
  errors VARCHAR(255),
  is_fraud SMALLINT
);
