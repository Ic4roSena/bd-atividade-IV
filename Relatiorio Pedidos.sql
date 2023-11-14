Create Database Atividade5;
Use Atividade5;


CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255),
    telefone VARCHAR(20)
);

-- Criação da tabela "pedidos"
CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Inserir registros na tabela "clientes"
INSERT INTO clientes (id_cliente, nome, email, telefone)
VALUES
    (1, 'Vanderlan Batista', 'VanderlanB@gmail.com', '(71) 998567-2265'),
    (2, 'Arthur Murillo', 'MurilloArthur@gmail.com', '(71) 995485-6658'),
    (3, 'Jorge Neto', 'JJNeto@gmail.com', '(71) 95248-6215'),
    (4, 'Aiane Vitoria', 'Aiane@gmail.com', '(71) 98818-8558');

-- Inserir registros na tabela "pedidos"
INSERT INTO pedidos (id_pedido, id_cliente, data_pedido, valor_total)
VALUES
    (1, 1, '2023-05-08', 100.00),
    (2, 1, '2023-10-01', 150.00),
    (3, 2, '2023-07-22', 75.00),
    (4, 3, '2023-09-30', 200.00);

-- Criação da view "relatorio_pedidos_cliente"
CREATE VIEW relatorio_pedidos_cliente AS
SELECT
    c.nome AS nome_do_cliente,
    COUNT(p.id_pedido) AS numero_de_pedidos,
    SUM(p.valor_total) AS valor_total_gasto
FROM
    clientes c
LEFT JOIN
    pedidos p ON c.id_cliente = p.id_cliente
GROUP BY
    c.id_cliente;

SELECT * FROM relatorio_pedidos_cliente;
