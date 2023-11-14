Use Atividade5;

-- Criação da tabela "funcionarios"
CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(255),
    cargo VARCHAR(255),
    salario DECIMAL(10, 2)
);

-- Criação da tabela "vendas"
CREATE TABLE vendas (
    id_venda INT PRIMARY KEY,
    id_funcionario INT,
    data_venda DATE,
    valor_venda DECIMAL(10, 2),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
);

-- Inserir registros na tabela "funcionarios"
INSERT INTO funcionarios (id_funcionario, nome, cargo, salario)
VALUES
    (1, 'Sergio Rodrigues', 'Vendedor', 2500.00),
    (2, 'Moises dos Santos', 'Vendedor', 2800.00),
    (3, 'Marcos Felipe', 'Gerente', 3500.00),
    (4, 'Igor Nascimento', 'Vendedor', 2700.00);

-- Inserir registros na tabela "vendas"
INSERT INTO vendas (id_venda, id_funcionario, data_venda, valor_venda)
VALUES
    (1, 1, '2023-02-01', 1000.00),
    (2, 2, '2023-05-09', 1200.00),
    (3, 1, '2023-06-11', 800.00),
    (4, 3, '2023-08-15', 1500.00),
    (5, 4, '2023-11-30', 1100.00);

-- Criação da view "relatorio_vendas_funcionario"
CREATE VIEW relatorio_vendas_funcionario AS
SELECT
    f.nome AS nome_do_funcionario,
    COUNT(v.id_venda) AS numero_de_vendas,
    SUM(v.valor_venda) AS valor_total_vendas
FROM
    funcionarios f
LEFT JOIN
    vendas v ON f.id_funcionario = v.id_funcionario
GROUP BY
    f.id_funcionario;

SELECT * FROM relatorio_vendas_funcionario;
