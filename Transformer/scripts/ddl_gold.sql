-- SCHEMA GOLD
CREATE SCHEMA IF NOT EXISTS dw;

-- DIM CLIENT
CREATE TABLE IF NOT EXISTS dw.dim_client (
  sk_client BIGSERIAL PRIMARY KEY,
  client_id BIGINT,
  gender VARCHAR(10),
  current_age INT,
  birth_year INT,
  birth_month INT,
  per_capita_income DOUBLE PRECISION,
  yearly_income DOUBLE PRECISION,
  total_debt DOUBLE PRECISION,
  credit_score BIGINT
);

-- DIM TIME
CREATE TABLE IF NOT EXISTS dw.dim_time (
  sk_time BIGSERIAL PRIMARY KEY,
  date DATE,
  year INT,
  quarter INT,
  month INT,
  day INT
);

-- DIM CARDS
CREATE TABLE IF NOT EXISTS dw.dim_cards (
  sk_card BIGSERIAL PRIMARY KEY,
  card_id BIGINT,
  card_brand VARCHAR(100),
  card_type VARCHAR(100),
  has_chip VARCHAR(20),
  credit_limit DOUBLE PRECISION,
  acct_open_date DATE,
  card_on_dark_web VARCHAR(10),
  num_cards_issued BIGINT
);

-- DIM MERCHANT
CREATE TABLE IF NOT EXISTS dw.dim_merchant (
  sk_merchant BIGSERIAL PRIMARY KEY,
  merchant_id VARCHAR(50),
  merchant_city VARCHAR(100),
  merchant_state VARCHAR(50),
  zip BIGINT,
  mcc BIGINT,
  mcc_description VARCHAR(255)
);

-- FACT TRANSACTIONS
CREATE TABLE IF NOT EXISTS dw.fact_transactions (
  sk_transaction BIGSERIAL PRIMARY KEY,
  fk_client BIGINT REFERENCES dw.dim_client(sk_client),
  fk_time BIGINT REFERENCES dw.dim_time(sk_time),
  fk_card BIGINT REFERENCES dw.dim_cards(sk_card),
  fk_merchant BIGINT REFERENCES dw.dim_merchant(sk_merchant),
  amount DOUBLE PRECISION,
  use_chip VARCHAR(40),
  errors VARCHAR(255),
  is_fraud INT
);
