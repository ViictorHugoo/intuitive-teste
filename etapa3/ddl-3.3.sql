CREATE DATABASE 
	IF NOT EXISTS intuitive;
    
USE intuitive; 


CREATE TABLE OPERADORAS_ATIVAS (
    registro_operadora VARCHAR(6) NOT NULL,
    cnpj VARCHAR(14) NOT NULL,
    razao_social VARCHAR(140) NOT NULL,
    nome_fantasia VARCHAR(140) NOT NULL,
    modalidade VARCHAR(2) NOT NULL,
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(50) NOT NULL,
    cargo_representante VARCHAR(40),
    regiao_de_comercializacao ENUM(
        'Regiao 1',
        'Regiao 2',
        'Regiao 3',
        'Regiao 4',
        'Regiao 5',
        'Regiao 6'
    ) NOT NULL,
    data_registro_ans DATE NOT NULL,
    CONSTRAINT PK_OPERADORAS_ATIVAS PRIMARY KEY (registro_operadora)
) ENGINE = InnoDB;


CREATE TABLE ENDERECOS_OPERADORA (
    registro_operadora VARCHAR(6) NOT NULL,
    logradouro VARCHAR(40),
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(40),
    bairro VARCHAR(30),
    cidade VARCHAR(30),
    uf CHAR(2),
    cep VARCHAR(8) NOT NULL,
    PRIMARY KEY (cep, numero),
    CONSTRAINT FK_ENDERECOS_OPERADORA_OPERADORAS_ATIVAS 
        FOREIGN KEY (registro_operadora) 
        REFERENCES OPERADORAS_ATIVAS(registro_operadora)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE = InnoDB;


CREATE TABLE TELEFONES_OPERADORA (
    id INT AUTO_INCREMENT,
    registro_operadora VARCHAR(6) NOT NULL,
    telefone VARCHAR(20),
    ddd VARCHAR(4),
    fax VARCHAR(20),
    CONSTRAINT PK_TELEFONES_OPERADORA PRIMARY KEY (id),
    CONSTRAINT FK_TELEFONES_OPERADORA_OPERADORAS_ATIVAS 
        FOREIGN KEY (registro_operadora) 
        REFERENCES OPERADORAS_ATIVAS(registro_operadora)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1;


CREATE TABLE DEMONSTRACOES_CONTABEIS (
    registro_operadora VARCHAR(6) NOT NULL,
    data_trimestre DATE NOT NULL,
    codigo_conta VARCHAR(9) NOT NULL,
    descricao VARCHAR(150) NOT NULL,
    saldo_inicial FLOAT(8) NOT NULL,
    saldo_final FLOAT(8) NOT NULL,
    CONSTRAINT PK_DEMONSTRACOES_CONTABEIS PRIMARY KEY (registro_operadora, data_trimestre),
    CONSTRAINT FK_DEMONSTRACOES_CONTABEIS_OPERADORAS_ATIVAS 
        FOREIGN KEY (registro_operadora) 
        REFERENCES OPERADORAS_ATIVAS(registro_operadora)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE = InnoDB;


