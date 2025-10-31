-- Visão geral do Data Warehouse
-- Volume de transações e fraudes por mês
SELECT
    t.year,
    t.month,
    COUNT(*)                     AS total_transactions,
    SUM(ft.amount)               AS total_amount,
    SUM(CASE WHEN ft.is_fraud = 1 THEN ft.amount ELSE 0 END) AS total_fraud
FROM dw.fact_transactions ft
JOIN dw.dim_time t ON ft.fk_time = t.sk_time
GROUP BY t.year, t.month
ORDER BY t.year, t.month;

-- Distribuição de fraudes por estado
SELECT
    m.merchant_state,
    COUNT(*) AS total_frauds
FROM dw.fact_transactions ft
JOIN dw.dim_merchant m ON ft.fk_merchant = m.sk_merchant
WHERE ft.is_fraud = 1
GROUP BY m.merchant_state
ORDER BY total_frauds DESC;

-- Top 10 comerciantes com maior volume de transações
SELECT
    m.merchant_city,
    m.merchant_state,
    SUM(ft.amount) AS total_amount
FROM dw.fact_transactions ft
JOIN dw.dim_merchant m ON ft.fk_merchant = m.sk_merchant
GROUP BY m.merchant_city, m.merchant_state
ORDER BY total_amount DESC
LIMIT 10;

-- Renda média e score de crédito médio por faixa etária
SELECT
    c.current_age,
    AVG(c.yearly_income)  AS avg_income,
    AVG(c.credit_score)   AS avg_credit_score
FROM dw.dim_client c
GROUP BY c.current_age
ORDER BY c.current_age;
 
-- Analisando o perfil de fraude
-- 1. Estados com maior taxa de fraude
SELECT
    m.merchant_state,
    COUNT(ft.sk_transaction) AS total_transactions,
    SUM(CASE WHEN ft.is_fraud = 1 THEN 1 ELSE 0 END) AS total_frauds,
    ROUND(100.0 * SUM(CASE WHEN ft.is_fraud = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS fraud_rate
FROM dw.fact_transactions ft
JOIN dw.dim_merchant m ON ft.fk_merchant = m.sk_merchant
GROUP BY m.merchant_state
ORDER BY fraud_rate DESC

-- 2. Faixa etária mais suscetível a fraudes
SELECT
    c.current_age,
    COUNT(ft.sk_transaction) AS total_transactions,
    SUM(CASE WHEN ft.is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_count,
    ROUND(100.0 * SUM(CASE WHEN ft.is_fraud = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS fraud_rate
FROM dw.fact_transactions ft
JOIN dw.dim_client c ON ft.fk_client = c.sk_client
GROUP BY c.current_age
ORDER BY fraud_rate DESC

-- 3. Tipos de cartão com mais fraudes
SELECT
    cd.card_type,
    COUNT(ft.sk_transaction) AS total_transactions,
    SUM(CASE WHEN ft.is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_count,
    ROUND(100.0 * SUM(CASE WHEN ft.is_fraud = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS fraud_rate
FROM dw.fact_transactions ft
JOIN dw.dim_cards cd ON ft.fk_card = cd.sk_card
GROUP BY cd.card_type
ORDER BY fraud_rate DESC

-- Analisando comportamento do perfil de crédito dos clientes
-- 1. Distribuição de clientes por quantidade de cartões
SELECT
    c.num_credit_cards,
    COUNT(*) AS num_clients
FROM dw.dim_client c
GROUP BY c.num_credit_cards
ORDER BY c.num_credit_cards

-- 2. Distribuição de limite de crédito médio por faixa de renda
SELECT
    CASE
        WHEN c.yearly_income < 30000 THEN 'Baixa renda'
        WHEN c.yearly_income BETWEEN 30000 AND 70000 THEN 'Média renda'
        ELSE 'Alta renda'
    END AS faixa_renda,
    ROUND(AVG(cd.credit_limit), 2) AS avg_credit_limit,
    ROUND(AVG(c.credit_score), 2) AS avg_credit_score
FROM dw.dim_client c
JOIN dw.dim_cards cd ON cd.card_id = c.client_id
GROUP BY faixa_renda
ORDER BY faixa_renda

-- 3. Idade média e limite de crédito médio por gênero
SELECT
    c.gender,
    ROUND(AVG(c.current_age), 1) AS avg_age,
    ROUND(AVG(cd.credit_limit), 2) AS avg_credit_limit
FROM dw.dim_client c
JOIN dw.dim_cards cd ON cd.card_id = c.client_id
GROUP BY c.gender
ORDER BY avg_credit_limit DESC

-- Analisando transações
-- 1. Top 15 cidades com maior volume de transações
SELECT
    m.merchant_city,
    m.merchant_state,
    COUNT(ft.sk_transaction) AS total_transactions,
    ROUND(SUM(ft.amount), 2) AS total_amount
FROM dw.fact_transactions ft
JOIN dw.dim_merchant m ON ft.fk_merchant = m.sk_merchant
GROUP BY m.merchant_city, m.merchant_state
ORDER BY total_amount DESC
LIMIT 15

-- 2. Volume de transações por trimestre
SELECT
    t.year,
    t.quarter,
    COUNT(*) AS total_transactions,
    SUM(ft.amount) AS total_amount
FROM dw.fact_transactions ft
JOIN dw.dim_time t ON ft.fk_time = t.sk_time
GROUP BY t.year, t.quarter
ORDER BY t.year, t.quarter

-- 3. Média de valor transacionado por tipo de cartão
SELECT
    cd.card_type,
    ROUND(AVG(ft.amount), 2) AS avg_transaction_amount
FROM dw.fact_transactions ft
JOIN dw.dim_cards cd ON ft.fk_card = cd.sk_card
GROUP BY cd.card_type
ORDER BY avg_transaction_amount DESC
