Use Atividade5;

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(255),
    preco_unitario DECIMAL(10, 2),
    categoria VARCHAR(255)
);

-- Criação da tabela "estoque"
CREATE TABLE estoque (
    id_produto INT,
    quantidade INT,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

-- Inserir registros na tabela "produtos"
INSERT INTO produtos (id_produto, nome, preco_unitario, categoria)
VALUES
    (1, 'Televisão', 10.00, 'Eletrônicos'),
    (2, 'Geladeira', 20.00, 'Eletrônicos'),
    (3, 'Moletom', 15.00, 'Roupas'),
    (4, 'Ventilador', 30.00, 'Eletrônicos');

-- Inserir registros na tabela "estoque"
INSERT INTO estoque (id_produto, quantidade)
VALUES
    (1, 5),
    (2, 8),
    (3, 2),
    (4, 3);

-- Criação da view "estoque_critico"
CREATE VIEW estoque_critico AS
SELECT
    p.nome AS nome_do_produto,
    e.quantidade AS quantidade_em_estoque
FROM
    produtos p
JOIN
    estoque e ON p.id_produto = e.id_produto
WHERE
    e.quantidade < 5; -- Defina o limite de estoque crítico conforme necessário

SELECT * FROM estoque_critico;
