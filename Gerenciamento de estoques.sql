Use Atividade4;

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(255),
    quantidade_estoque INT
);

-- Criação da tabela "vendas"
CREATE TABLE vendas (
    id_venda INT PRIMARY KEY,
    data_venda DATETIME
);

-- Criação da tabela "itens_venda"
CREATE TABLE itens_venda (
    id_item_venda INT PRIMARY KEY,
    id_venda INT,
    id_produto INT,
    quantidade INT,
    FOREIGN KEY (id_venda) REFERENCES vendas(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

DELIMITER //

-- Criação do trigger
CREATE TRIGGER verificar_estoque_produto
BEFORE INSERT ON itens_venda
FOR EACH ROW
BEGIN
    DECLARE estoque_atual INT;

    -- Obter a quantidade em estoque do produto correspondente
    SELECT quantidade_estoque INTO estoque_atual
    FROM produtos
    WHERE id_produto = NEW.id_produto;

    -- Verificar se a quantidade em estoque é suficiente
    IF NEW.quantidade > estoque_atual THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Produto fora de estoque';
    END IF;
END;
//

DELIMITER ;

-- Inserir um produto com estoque
INSERT INTO produtos (id_produto, nome, quantidade_estoque)
VALUES (1, 'Uvas', 10);

-- Inserir uma venda com um item de venda (quantidade dentro do estoque)
INSERT INTO vendas (id_venda, data_venda) VALUES (1, '2023-01-01 12:00:00');
INSERT INTO itens_venda (id_item_venda, id_venda, id_produto, quantidade)
VALUES (1, 1, 1, 5);

-- Tente inserir um item de venda com quantidade maior do que o estoque
INSERT INTO vendas (id_venda, data_venda) VALUES (2, '2023-02-01 14:00:00');
INSERT INTO itens_venda (id_item_venda, id_venda, id_produto, quantidade)
VALUES (2, 2, 1, 15); -- Isso gerará um erro no trigger

select * from produtos;
select * from itens_venda;
