# Financial Transactions Data Warehouse

## Descrição
Este projeto tem como objetivo construir um **Data Warehouse** sobre transações financeiras utilizando a **arquitetura Medallion** (Bronze, Silver e Gold) e modelagem **Star Schema**.  
O projeto é voltado para aprendizado e aplicação prática em **Engenharia de Dados** e inclui:

- Organização do repositório em camadas:
  - `Data Layer`   
    - `raw/` (Bronze) – dados originais e metadados (dicionário de dados).
    - `silver/` (Silver) – dados limpos e transformados, com Lakehouse.  
    - `gold/` (Gold) – Data Warehouse com tabelas fato e dimensões.
  - `Transformer`
    - `scripts` - Scripts DDL do banco de dados
    - `etl_raw_to_silver.ipynb` - Notebook de ETL da camada bronze para silver.
    - - Modelagem conceitual e lógica do DW (MER, DER, DLD) em PDF


## Dataset utilizado
[Transactions Fraud Dataset - Kaggle](https://www.kaggle.com/datasets/computingvictor/transactions-fraud-datasets)  

## Estrutura do Repositório
    financial-transactions-dwh/
      ├── Data Layer 
        ├── raw/ # Bronze: dados originais e metadados
        ├── silver/ # Silver: notebooks ETL, tabelona Lakehouse
        ├── gold/ # Gold: tabelas fato e dimensão em CSV
      ├── Transformer
        ├── scripts/
        ├── notebooks para etl

## Objetivo 
Construção de um projeto de Engenharia de Dados de ponta a ponta, exercitando **ETL, modelagem Star Schema, documentação de dados e análise exploratória**.

## Como Rodar
1. Criar o ambiente virtual Python e instalar dependências:
`python -m venv venv`
`source venv/bin/activate`
`pip install -r requirements.txt

2. Executar o ambiente docker:
`docker-compose up --build -d`
