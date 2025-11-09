--  SEÇÃO 1 - ANALYZE CUSTOMER LIFETIME VALUE (CLV)
-- Query 01 - Valor total e ticket médio por cliente
-- GRÁFICO: Barra
SELECT
    c.srk_clt,
    c.clt_ide,
    c.gdr,
    c.crt_age,
    c.yrl_icm,
    ROUND(SUM(ft.amt)::numeric, 2) AS ttl_amt,
    ROUND(AVG(ft.amt)::numeric, 2) AS avg_tkt,
    COUNT(ft.srk_trn) AS num_trn
FROM dwh.fat_trn ft
JOIN dwh.dim_clt c ON ft.srk_clt = c.srk_clt
GROUP BY c.srk_clt, c.clt_ide, c.gdr, c.crt_age, c.yrl_icm
ORDER BY ttl_amt DESC

-- Query 02 - Valor total por faixa etária
-- GRÁFICO: Barra
SELECT
    CASE 
        WHEN c.crt_age BETWEEN 18 AND 25 THEN '18–25'
        WHEN c.crt_age BETWEEN 26 AND 35 THEN '26–35'
        WHEN c.crt_age BETWEEN 36 AND 50 THEN '36–50'
        WHEN c.crt_age > 50 THEN '50+'
        ELSE 'Desconhecido'
    END AS age_grp,
    COUNT(DISTINCT c.clt_ide) AS num_clt,
    ROUND(SUM(ft.amt)::numeric, 2) AS ttl_amt
FROM dwh.fat_trn ft
JOIN dwh.dim_clt c ON ft.srk_clt = c.srk_clt
GROUP BY age_grp
ORDER BY ttl_amt DESC

-- Query 03 - Ticket médio e gasto total por faixa de renda
-- GRÁFICO: Barra

SELECT
    CASE 
        WHEN c.yrl_icm < 20000 THEN 'Baixa'
        WHEN c.yrl_icm BETWEEN 20000 AND 50000 THEN 'Média'
        WHEN c.yrl_icm BETWEEN 50000 AND 100000 THEN 'Alta'
        ELSE 'Muito Alta'
    END AS icm_band,
    ROUND(AVG(ft.amt)::numeric, 2) AS avg_tkt,
    ROUND(SUM(ft.amt)::numeric, 2) AS ttl_amt,
    COUNT(ft.srk_trn) AS num_trn,
    COUNT(DISTINCT c.clt_ide) AS num_clt
FROM dwh.fat_trn ft
JOIN dwh.dim_clt c ON ft.srk_clt = c.srk_clt
GROUP BY icm_band
ORDER BY ttl_amt DESC

-- Query 04 - Índice de endividamento x gasto total
-- GRÁFICO: Ponto

SELECT
    c.clt_ide,
    ROUND((c.ttl_dbt / NULLIF(c.yrl_icm, 0))::numeric, 2) AS dbt_idx,
    ROUND(SUM(ft.amt)::numeric, 2) AS ttl_spt
FROM dwh.fat_trn ft
JOIN dwh.dim_clt c ON ft.srk_clt = c.srk_clt
WHERE c.yrl_icm IS NOT NULL AND c.ttl_dbt IS NOT NULL
GROUP BY c.clt_ide, c.ttl_dbt, c.yrl_icm
HAVING (c.ttl_dbt / NULLIF(c.yrl_icm, 0)) < 10
ORDER BY ttl_spt DESC

--   SEÇÃO 2 - STUDY MARKET TRENDS
-- Query 06 - Volume e valor de transações por mês
-- GRÁFICO: Linha
SELECT
    t.yrr,
    t.mth,
    COUNT(*) AS num_trn,
    ROUND(SUM(ft.amt)::numeric, 2) AS ttl_amt
FROM dwh.fat_trn ft
JOIN dwh.dim_tim t ON ft.srk_tim = t.srk_tim
GROUP BY t.yrr, t.mth
ORDER BY t.yrr, t.mth

-- Query 07 - Distribuição de clientes por score de crédito
-- GRÁFICO: Pizza
SELECT
    CASE 
        WHEN c.cdt_scr < 650 THEN 'Baixo'
        WHEN c.cdt_scr BETWEEN 650 AND 850 THEN 'Médio'
        ELSE 'Alto'
    END AS scr_rng,
    COUNT(*) AS num_clt
FROM dwh.dim_clt c
GROUP BY scr_rng
ORDER BY num_clt DESC

-- Query 8 - Limite médio de crédito por tipo de cartão
-- GRÁFICO: Barra

SELECT
    COALESCE(dc.crd_tpe, 'Desconhecido') AS crd_tpe,
    ROUND(AVG(dc.cdt_lmt)::numeric, 2) AS avg_lmt,
    COUNT(ft.srk_trn) AS num_trn
FROM dwh.fat_trn ft
JOIN dwh.dim_crd dc ON ft.srk_crd = dc.srk_crd
GROUP BY dc.crd_tpe
ORDER BY avg_lmt DESC;