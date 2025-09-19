# Dicionário de Dados - Transações Financeiras

### 1 - transactions_data.csv

| Coluna            | Tipo   | Descrição                                      | Observações                        |
| ----------------- | ------ | ---------------------------------------------- | ---------------------------------- |
| transaction\_id   | STRING | Identificador único da transação               | PK da tabela original              |
| user\_id          | STRING | Identificador do usuário                       | FK implícita para `users_data`     |
| card\_id          | STRING | Identificador do cartão                        | FK implícita para `cards_data`  |
| merchant\_id      | STRING | Identificador do comerciante                   | FK implícita para `mcc_codes` |
| mcc\_code         | STRING | Código da categoria do comerciante (MCC)       | Código padrão do setor             |
| timestamp         | STRING | Data e hora da transação                       | Formato: `YYYY-MM-DD HH:MM:SS`     |
| amount            | DOUBLE | Valor da transação                             | Pode conter valores nulos          |
| transaction\_type | STRING | Tipo da transação (purchase, refund, etc.)     | Opcional                           |
| status            | STRING | Status da transação (aprovada, recusada, etc.) | Opcional                           |
| currency          | STRING | Moeda utilizada na transação                   | Ex: USD, EUR, BRL                  |


### 2 - cards_data.csv 
| Coluna       | Tipo   | Descrição                                   | Observações                    |
| ------------ | ------ | ------------------------------------------- | ------------------------------ |
| card\_id     | STRING | Identificador único do cartão               | PK                             |
| user\_id     | STRING | Identificador do usuário                    | FK implícita para `users_data` |
| card\_type   | STRING | Tipo de cartão (debit, credit, prepaid)     |                                |
| card\_limit  | DOUBLE | Limite do cartão                            |                                |
| issue\_date  | STRING | Data de emissão do cartão                   | Formato: `YYYY-MM-DD`          |
| expiry\_date | STRING | Data de validade do cartão                  | Formato: `YYYY-MM-DD`          |
| status       | STRING | Status do cartão (active, blocked, expired) |                                |

### 3 - users_data.csv
| Coluna            | Tipo   | Descrição                      | Observações           |
| ----------------- | ------ | ------------------------------ | --------------------- |
| user\_id          | STRING | Identificador único do usuário | PK                    |
| first\_name       | STRING | Primeiro nome do usuário       |                       |
| last\_name        | STRING | Sobrenome do usuário           |                       |
| gender            | STRING | Gênero do usuário              | M/F/Outro             |
| birthdate         | STRING | Data de nascimento             | Formato: `YYYY-MM-DD` |
| account\_creation | STRING | Data de criação da conta       | Formato: `YYYY-MM-DD` |
| city              | STRING | Cidade do usuário              |                       |
| state             | STRING | Estado do usuário              |                       |
| country           | STRING | País do usuário                |                       |
| customer\_type    | STRING | Tipo de cliente (segmentação)  | Opcional              |


### 4 - mcc_codes.json
| Coluna           | Tipo   | Descrição                          | Observações          |
| ---------------- | ------ | ---------------------------------- | -------------------- |
| mcc\_code        | STRING | Código de categoria do comerciante | PK                   |
| mcc\_description | STRING | Descrição do código MCC            | Ex: "Grocery Stores" |
| industry         | STRING | Setor associado ao código MCC      | Opcional             |

### 5 - train_fraud_labels.json 
| Coluna          | Tipo   | Descrição                                    | Observações                               |
| --------------- | ------ | -------------------------------------------- | ----------------------------------------- |
| transaction\_id | STRING | Identificador da transação                   | FK implícita para `transactions_data.csv` |
| is\_fraud       | INT    | Indicador de fraude (1 = fraude, 0 = normal) | Binário                                   |
