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
financial-transactions-dwh/
│
├── raw/ # Bronze: dados originais e metadados
├── silver/ # Silver: notebooks ETL, tabelona Lakehouse
├── gold/ # Gold: tabelas fato e dimensão em CSV
└── data_visualization/ # Dashboards Power BI e consultas SQL



## Objetivo 
Construção de um projeto de Engenharia de Dados de ponta a ponta, exercitando **ETL, modelagem Star Schema, documentação de dados e análise exploratória**.

## Como Rodar
1. Criar o ambiente virtual Python:
```bash
python -m venv venv
source venv/bin/activate

1. Instalar dependências:
```bash
pip install -r requirements.txt

