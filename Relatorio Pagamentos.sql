Use Atividade6;

-- Criação da tabela "clientes"
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(255),
    endereco VARCHAR(255),
    cidade VARCHAR(255)
);

-- Criação da tabela "pagamentos"
CREATE TABLE pagamentos (
    id_pagamento INT PRIMARY KEY,
    id_cliente INT,
    data_pagamento DATE,
    valor_pagamento DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Inserir registros na tabela "clientes"
INSERT INTO clientes (id_cliente, nome, endereco, cidade)
VALUES
    (1, 'Sergio Rodrigues', 'Dendezeiros', 'Salvador'),
    (2, 'Moises dos Santos', 'Avenida Paulista', 'São Paulo'),
    (3, 'Marcos Felipe', 'Copacabana', 'Rio de Janeiro'),
    (4, 'Igor Nascimento', 'Rua João da Silva', 'Pernambuco');

-- Inserir registros na tabela "pagamentos"
INSERT INTO pagamentos (id_pagamento, id_cliente, data_pagamento, valor_pagamento)
VALUES
    (1, 1, '2023-06-01', 100.00),
    (2, 2, '2023-11-15', 150.00),
    (3, 1, '2023-10-03', 80.00),
    (4, 3, '2023-07-04', 120.00),
    (5, 4, '2023-01-05', 90.00);

-- Criação da view "relatorio_pagamentos_cidade"
CREATE VIEW relatorio_pagamentos_cidade AS
SELECT
    c.cidade AS nome_da_cidade,
    SUM(p.valor_pagamento) AS valor_total_pagamentos
FROM
    clientes c
LEFT JOIN
    pagamentos p ON c.id_cliente = p.id_cliente
GROUP BY
    c.cidade;

SELECT * FROM relatorio_pagamentos_cidade;
