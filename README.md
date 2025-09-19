# Financial Transactions Data Warehouse

## Descrição
Este projeto tem como objetivo construir um **Data Warehouse** sobre transações financeiras utilizando a **arquitetura Medallion** (Bronze, Silver e Gold) e modelagem **Star Schema**.  
O projeto é voltado para aprendizado e aplicação prática em **Engenharia de Dados** e inclui:

- Organização do repositório em camadas:  
  - `raw/` (Bronze) – dados originais e metadados  
  - `silver/` (Silver) – dados limpos e transformados, com Lakehouse  
  - `gold/` (Gold) – Data Warehouse com tabelas fato e dimensões exportadas como CSV  
- Documentação completa dos dados (dicionário de dados)  
- Jobs ETL para transformação de dados  
- Modelagem conceitual e lógica do DW (MER, DER, DLD)  
- Consultas SQL para análise e visualização  
- Preparação de dashboards no Power BI  

## Dataset utilizado
[Transactions Fraud Dataset - Kaggle](https://www.kaggle.com/datasets/computingvictor/transactions-fraud-datasets)  

## Estrutura do Repositório
