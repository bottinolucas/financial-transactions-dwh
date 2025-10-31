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
 