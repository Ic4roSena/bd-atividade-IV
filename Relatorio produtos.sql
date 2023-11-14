Create Database Atividade6;
Use Atividade6;


CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY,
    nome_categoria VARCHAR(255),
    descricao VARCHAR(255)
);


CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(255),
    preco_unitario DECIMAL(10, 2),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);


INSERT INTO categorias (id_categoria, nome_categoria, descricao)
VALUES
    (1, 'Eletrônicos', 'Produtos eletrônicos diversos'),
    (2, 'Roupas', 'Vestuário e acessórios'),
    (3, 'Móveis', 'Móveis para casa'),
    (4, 'Alimentos', 'Produtos alimentícios variados');


INSERT INTO produtos (id_produto, nome, preco_unitario, id_categoria)
VALUES
    (1, 'Sanduicheira', 100.00, 1),
    (2, 'Ferro de passar roupa', 50.00, 1),
    (3, 'Camisa do Bahia', 20.00, 2),
    (4, 'Sofá', 300.00, 3),
    (5, 'Refrigerante', 10.00, 4),
    (6, 'Pringles', 25.00, 4),
    (7, 'Calça Moletom', 30.00, 2);


CREATE VIEW relatorio_produtos_categoria AS
SELECT
    c.nome_categoria AS nome_da_categoria,
    COUNT(p.id_produto) AS quantidade_de_produtos
FROM
    categorias c
LEFT JOIN
    produtos p ON c.id_categoria = p.id_categoria
GROUP BY
    c.id_categoria;

SELECT * FROM relatorio_produtos_categoria;
