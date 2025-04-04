use intuitive;

LOAD DATA INFILE '"Relatorio_cadop.csv"'
INTO TABLE OPERADORAS_ATIVAS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(registro_operadora, cnpj, razao_social, nome_fantasia, modalidade, 
 logradouro, numero, complemento, bairro, cidade, uf, cep, 
 ddd, telefone, fax, endereco_eletronico, 
 representante, cargo_representante, 
 regiao_de_comercializacao, data_registro_ans);
 
LOAD DATA INFILE '1T2023.csv'
INTO TABLE DEMONSTRACOES_CONTABEIS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(data_trimestre, registro_operadora, codigo_conta, descricao, saldo_inicial, saldo_final);

LOAD DATA INFILE '2T2023.csv'
INTO TABLE DEMONSTRACOES_CONTABEIS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(data_trimestre, registro_operadora, codigo_conta, descricao, saldo_inicial, saldo_final);

LOAD DATA INFILE '3T2023.csv'
INTO TABLE DEMONSTRACOES_CONTABEIS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(data_trimestre, registro_operadora, codigo_conta, descricao, saldo_inicial, saldo_final);

LOAD DATA INFILE '4T2023.csv'
INTO TABLE DEMONSTRACOES_CONTABEIS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(data_trimestre, registro_operadora, codigo_conta, descricao, saldo_inicial, saldo_final);

LOAD DATA INFILE '1T2024.csv'
INTO TABLE DEMONSTRACOES_CONTABEIS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(data_trimestre, registro_operadora, codigo_conta, descricao, saldo_inicial, saldo_final);

LOAD DATA INFILE '2T2024.csv'
INTO TABLE DEMONSTRACOES_CONTABEIS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(data_trimestre, registro_operadora, codigo_conta, descricao, saldo_inicial, saldo_final);

LOAD DATA INFILE '3T2024.csv'
INTO TABLE DEMONSTRACOES_CONTABEIS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(data_trimestre, registro_operadora, codigo_conta, descricao, saldo_inicial, saldo_final);

LOAD DATA INFILE '4T2024.csv'
INTO TABLE DEMONSTRACOES_CONTABEIS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(data_trimestre, registro_operadora, codigo_conta, descricao, saldo_inicial, saldo_final);
