--Criar Modelo Star--
CREATE TABLE CLIENTE
(
    IdCliente number(10, 0) NOT NULL,
    nif      number(9, 0)  NOT NULL,
    PRIMARY KEY (IdCliente)
);
CREATE TABLE PRODUTO
(
    IdProduto NUMBER(10, 0) NOT NULL,
    tipoProduto      VARCHAR2(255) NOT NULL,
    nomeProduto      VARCHAR2(255) NOT NULL,
    PRIMARY KEY (IdProduto)
);

CREATE TABLE TEMPO
(
    IdTempo NUMBER(10, 0) NOT NULL PRIMARY KEY,
    ano   NUMBER(4, 0)  NOT NULL,
    mes  NUMBER(2, 0)  NOT NULL CHECK ( mes BETWEEN 1 AND 12)
);

CREATE TABLE PRODUCAO
(
    IdProducao NUMBER(10, 0) NOT NULL,
    quantidade       NUMBER(10, 0) NOT NULL,
    IdTempo       NUMBER(10, 0) NOT NULL,
    IdSetor       NUMBER(10, 0) NOT NULL,
    IdProduto    NUMBER(10, 0) NOT NULL,
    PRIMARY KEY (IdProducao)
);
CREATE TABLE VENDA
(
    IdVenda    NUMBER(10, 0) NOT NULL,
    quantidade  NUMBER(10, 0) NOT NULL,
    IdTempo    NUMBER(10, 0) NOT NULL,
    IdCliente  NUMBER(10, 0) NOT NULL,
    IdProduto NUMBER(10, 0) NOT NULL,
    PRIMARY KEY (IdVenda)
);
CREATE TABLE SETOR
(
    IdSetor    NUMBER(10, 0) NOT NULL,
    nomeProduto    VARCHAR2(255) NOT NULL,
    cultura      VARCHAR2(255) NOT NULL,
    PRIMARY KEY (IdSetor)
);


ALTER TABLE PRODUCAO
    ADD CONSTRAINT FKProducaoIdSetor FOREIGN KEY (IdSetor) REFERENCES SETOR (IdSetor);
ALTER TABLE PRODUCAO
    ADD CONSTRAINT FKProducaoIdProduto FOREIGN KEY (IdProduto) REFERENCES PRODUTO (IdProduto);
ALTER TABLE PRODUCAO
    ADD CONSTRAINT FKProducaoIdTempo FOREIGN KEY (IdTempo) REFERENCES TEMPO (IdTempo);


ALTER TABLE VENDA
    ADD CONSTRAINT FKVendaIdCliente FOREIGN KEY (IdCliente) REFERENCES CLIENTE (IdCliente);
ALTER TABLE VENDA
    ADD CONSTRAINT FKVendaIdProduto FOREIGN KEY (IdProduto) REFERENCES PRODUTO (IdProduto);
ALTER TABLE VENDA
    ADD CONSTRAINT FKVendaIdTempo FOREIGN KEY (IdTempo) REFERENCES TEMPO (IdTempo);


--OPTIONAL BOOT--
DECLARE
     yearCounter  NUMBER(4, 0);
     monthCounter NUMBER(2, 0);
    timeC             NUMBER(8, 0)  := 1;
    ContadorVendas       NUMBER(10, 0) := 1;
    ContadorProducoes NUMBER(10, 0) := 0;

BEGIN
    FOR yearCounter IN 2016..2021
        LOOP
            FOR monthCounter IN 1..12
                LOOP
                    INSERT INTO TEMPO(IdTempo, ano, mes) VALUES (timeC, yearCounter, monthCounter);
                    timeC := timeC + 1;
                end loop;
        end loop;
    COMMIT;
end;

    INSERT INTO PRODUTO(IdProduto, tipoProduto, nomeProduto) VALUES (1, 'Permanent', 'Apple');
    INSERT INTO PRODUTO(IdProduto, tipoProduto, nomeProduto) VALUES (2, 'Permanent', 'Pear');
    INSERT INTO PRODUTO(IdProduto, tipoProduto, nomeProduto) VALUES (3, 'Permanent', 'Banana');
    INSERT INTO PRODUTO(IdProduto, tipoProduto, nomeProduto) VALUES (4, 'Permanent', 'Honey');
    INSERT INTO PRODUTO(IdProduto, tipoProduto, nomeProduto) VALUES (5, 'Temporary', 'Carrot');
    INSERT INTO PRODUTO(IdProduto, tipoProduto, nomeProduto) VALUES (6, 'Temporary', 'Potato');
    INSERT INTO PRODUTO(IdProduto, tipoProduto, nomeProduto) VALUES (7, 'Temporary', 'Strawberry');
    INSERT INTO PRODUTO(IdProduto, tipoProduto, nomeProduto) VALUES (8, 'Temporary', 'Asparagus');

    INSERT INTO CLIENTE(IdCliente, nif) VALUES (1, 987654321);
    INSERT INTO CLIENTE(IdCliente, nif) VALUES (2, 977654321);
    INSERT INTO CLIENTE(IdCliente, nif) VALUES (3, 988654321);

    INSERT INTO VENDA(IdVenda,quantidade,IdTempo,IdCliente,IdProduto) VALUES (4,18,38,1,5);
    INSERT INTO VENDA(IdVenda,quantidade,IdTempo,IdCliente,IdProduto) VALUES (1,15,39,1,5);
    INSERT INTO VENDA(IdVenda,quantidade,IdTempo,IdCliente,IdProduto) VALUES (3,19,40,1,5);
    INSERT INTO VENDA(IdVenda,quantidade,IdTempo,IdCliente,IdProduto) VALUES (5,11,50,1,5);
    INSERT INTO VENDA(IdVenda,quantidade,IdTempo,IdCliente,IdProduto) VALUES (2,20,51,1,5);
    INSERT INTO VENDA(IdVenda,quantidade,IdTempo,IdCliente,IdProduto) VALUES (6,14,52,1,5);

    INSERT INTO PRODUCAO(IdProducao,quantidade,IdTempo,IdSetor,IdProduto) VALUES (1,10,38,1,5);
    INSERT INTO PRODUCAO(IdProducao,quantidade,IdTempo,IdSetor,IdProduto) VALUES (2,10,39,1,5);
    INSERT INTO PRODUCAO(IdProducao,quantidade,IdTempo,IdSetor,IdProduto) VALUES (3,16,40,1,5);

    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (1, 'Carrot Field', 1);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (2, 'Carrot Field', 2);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (3, 'Carrot Field', 3);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (4, 'Potato Field', 1);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (5, 'Potato Field', 2);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (6, 'Potato Field', 3);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (7, 'Strawberry Field', 1);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (8, 'Strawberry Field', 2);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (9, 'Strawberry Field', 3);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (10, 'Asparagus Field', 1);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (11, 'Asparagus Field', 2);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (12, 'Asparagus Field', 3);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (13, 'Apple Orchard', 1);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (14, 'Apple Orchard', 2);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (15, 'Apple Orchard', 3);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (16, 'Pear Orchard', 1);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (17, 'Pear Orchard', 2);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (18, 'Pear Orchard', 3);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (19, 'Banana Orchard', 1);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (20, 'Banana Orchard', 2);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (21, 'Banana Orchard', 3);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (22, 'Beehive', 1);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (23, 'Beehive', 2);
    INSERT INTO SETOR(IdSetor, nomeProduto, cultura) VALUES (24, 'Beehive', 3);