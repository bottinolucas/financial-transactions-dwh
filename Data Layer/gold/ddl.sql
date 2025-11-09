CREATE SCHEMA IF NOT EXISTS dwh;

CREATE TABLE IF NOT EXISTS dwh.dim_clt (
  srk_clt BIGSERIAL PRIMARY KEY,
  clt_ide BIGINT,
  gdr VARCHAR(10),
  crt_age INT,
  per_cpt_icm DOUBLE PRECISION,
  yrl_icm DOUBLE PRECISION,
  ttl_dbt DOUBLE PRECISION,
  cdt_scr BIGINT,
  num_cdt_crd SMALLINT
);

CREATE TABLE IF NOT EXISTS dwh.dim_mer(
  srk_mer BIGSERIAL PRIMARY KEY,
  mer_ide VARCHAR(50),
  mer_cit VARCHAR(100),
  mer_stt VARCHAR(50),
  zip BIGINT,
  mcc BIGINT,
  mcc_dcp VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS dwh.dim_crd (
  srk_crd BIGSERIAL PRIMARY KEY,
  crd_ide BIGINT UNIQUE NOT NULL,
  crd_brd VARCHAR(100),
  crd_tpe VARCHAR(100),
  has_chp VARCHAR(10),
  cdt_lmt NUMERIC(18,2),
  act_opn_dat DATE,
  num_crd_isd SMALLINT,
  yrr_pin_lst_cgd SMALLINT
);

CREATE TABLE IF NOT EXISTS dwh.dim_tim (
  srk_tim BIGSERIAL PRIMARY KEY,
  dat DATE, 
  yrr INT,
  qtr INT,
  mth INT,
  day INT
);

-- FACT TRANSACTIONS
CREATE TABLE IF NOT EXISTS dwh.fat_trn (
  srk_trn BIGSERIAL PRIMARY KEY,
  srk_clt BIGINT REFERENCES dwh.dim_clt(srk_clt),
  srk_tim BIGINT REFERENCES dwh.dim_tim(srk_tim),
  srk_crd BIGINT REFERENCES dwh.dim_crd(srk_crd),
  srk_mer BIGINT REFERENCES dwh.dim_mer(srk_mer),
  amt DOUBLE PRECISION,
  use_chp VARCHAR(40),
  err VARCHAR(255)
);