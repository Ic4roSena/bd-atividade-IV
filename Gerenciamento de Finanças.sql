Use Atividade4;

-- Criação da tabela "contas"
CREATE TABLE contas (
    id_conta INT PRIMARY KEY,
    nome VARCHAR(255),
    saldo DECIMAL(10, 2)
);

-- Criação da tabela "transacoes"
CREATE TABLE transacoes (
    id_transacao INT PRIMARY KEY,
    id_conta INT,
    tipo VARCHAR(255),
    valor DECIMAL(10, 2),
    FOREIGN KEY (id_conta) REFERENCES contas(id_conta)
);

-- Criação do trigger para atualizar o saldo da conta ao inserir uma nova transação
DELIMITER //
CREATE TRIGGER atividade4.atualizar_saldo_conta
AFTER INSERT ON transacoes
FOR EACH ROW
BEGIN
    DECLARE valor_transacao DECIMAL(10, 2);

    -- Obtem o valor da nova transação
    SET valor_transacao = NEW.valor;

    -- Atualiza o saldo da conta correspondente com base no tipo da transação
    IF NEW.tipo = 'entrada' THEN
        UPDATE contas
        SET saldo = saldo + valor_transacao
        WHERE id_conta = NEW.id_conta;
    ELSEIF NEW.tipo = 'saída' THEN
        UPDATE contas
        SET saldo = saldo - valor_transacao
        WHERE id_conta = NEW.id_conta;
    END IF;
END;
//
DELIMITER ;


-- Inserir uma nova transação de entrada na tabela "transacoes"
INSERT INTO transacoes (id_transacao, id_conta, tipo, valor)
VALUES (1, 1, 'entrada', 100.00);

-- Inserir uma nova transação de saída na tabela "transacoes"
INSERT INTO transacoes (id_transacao, id_conta, tipo, valor)
VALUES (1, 1, 'saída', 50.00);


-- Inserir informações da primeira conta
INSERT INTO contas (id_conta, nome, saldo)
VALUES (1, 'Icaro Magnata', 3000000.00);

-- Inserir informações da segunda conta
INSERT INTO contas (id_conta, nome, saldo)
VALUES (2, 'Conta de Poupança', 150000.00);

select * from contas;