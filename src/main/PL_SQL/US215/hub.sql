-- US215
-- Como Gestor Agrícola, quero ter acesso à lista de hubs onde os meus clientes podem
-- recolher os meus produtos previamente encomendados.

-- Um cliente pode ter associado um hub por defeito – o local onde regularmente recolhe os produtos adquiridos.

-- No entanto, o ponto de recolha (hub) pode ser alterado para cada encomenda.

-- Posso também alterar o hub por defeito de um cliente.

-- A lista de hubs é atualizada sempre que necessário por intermédio da tabela input_hub(input_string VARCHAR(25))
-- onde são introduzidos os registos com essa informação, em formato csv, por um componente do meu sistema
-- de informação externo ao módulo de gestão da exploração.

-- Exemplo resgistos input_hub:
--  CT1;40.6389;-8.6553;C1 // ignorar C = cliente
--  CT2;38.0333;-7.8833;C2 // ignorar C = cliente
--  CT14;38.5243;-8.8926;E1 // hub
--  CT11;39.3167;-7.4167;E2 // hub
--  CT10;39.7444;-8.8072;P3 // hub

-- Este ficheiro tem informação sobre clientes e hubs. Os clientes têm um código no campo
-- Clientes-Produtores que começa com a letra C (os dois primeiros registos do exemplo acima).

-- Estes registos devem ser ignorados dado que não correspondem a hubs; os restantes registos
-- correspondem a hubs e devem ser persistidos na nossa base de dados numa tabela hub a incluir no
-- nosso esquema.


-- Critério de Aceitação [BDDAD]
--  1. É possível executar um procedimento para atualizar a tabela hub a partir da tabela
--  input_hub quando esta for atualizada. O código de um hub é o valor do campo Loc id

--  2. É possível atribuir e alterar o hub por defeito de um cliente.

--  3. Quando o cliente efetua uma nota de encomenda pode indicar um hub, distinto do seu hub por
--  defeito, para proceder à recolha dos produtos encomendados. O hub indicado deve ser válido,
--  i.e., deve existir na tabela hub.


CREATE TABLE Input_Hub(
input_string VARCHAR(25) NOT NULL
);

CREATE TABLE Hub (
  id_hub                varchar(6) NOT NULL,
  latitude              number(6,4) NOT NULL,
  longitude             number(6,4) NOT NULL,
  codigo           varchar(10) NOT NULL,
  PRIMARY KEY (loc_id));

INSERT INTO Input_hub VALUES('CT1;40.6389;-8.6553;C1');
INSERT INTO Input_hub VALUES('CT2;38.0333;-7.8833;C2');
INSERT INTO Input_hub VALUES('CT14;38.5243;-8.8926;E1');
INSERT INTO Input_hub VALUES('CT11;39.3167;-7.4167;E2');
INSERT INTO Input_hub VALUES('CT10;39.7444;-8.8072;P3');

DROP TABLE input_hub;
DROP TABLE hub;

-- ================================================================

--  1. É possível executar um procedimento para atualizar a tabela hub a partir da tabela
--  input_hub quando esta for atualizada. O código de um hub é o valor do campo Loc id.

CREATE OR REPLACE PROCEDURE atualizar_hub AS

    h_id varchar(6);
    lat number(6,4);
    lng number(6,4);
    cod_hub varchar(10);

    CURSOR c_import IS SELECT input_string FROM input_hub;

BEGIN
    -- cursor
    FOR info IN c_import LOOP
    BEGIN
        h_id := SUBSTR(info.input_string, 1, INSTR(info.input_string, ';') - 1);
        lat := TO_NUMBER(SUBSTR(info.input_string, INSTR(info.input_string, ';') + 1, INSTR(info.input_string, ';', 1, 2) - INSTR(info.input_string, ';') - 1),'9999.9999');
        lng := TO_NUMBER(SUBSTR(info.input_string, INSTR(info.input_string, ';', 1, 2) + 1, INSTR(info.input_string, ';', 1, 3) - INSTR(info.input_string, ';', 1, 2) - 1),'9999.9999');
        cod_hub := SUBSTR(info.input_string, INSTR(info.input_string, ';', 1, 3) + 1);

        -- Ignora os cod_hub que começam com "C" - Clientes
        IF cod_hub NOT LIKE 'C%'THEN
            INSERT INTO hub VALUES(h_id,lat,lng,cod_hub);
        END IF;

    END;
    END LOOP;
END;


-- Comando para executar
BEGIN atualizar_hub;
END;

SELECT * FROM HUB;

-- ================================================================================
--  2. É possível atribuir e alterar o hub por defeito de um cliente.

CREATE OR REPLACE PROCEDURE atribuir_hub_cliente (id_cliente IN cliente.codigo_interno%TYPE, wanted_hub VARCHAR) AS
    num_hubs integer;
BEGIN
  -- Verifica que o hub indicado existe na tabela hub
  SELECT COUNT(*) INTO num_hubs FROM hub WHERE id_hub = wanted_hub;
  IF num_hubs = 0 THEN
    -- Raise an error if the specified hub does not exist
    RAISE_APPLICATION_ERROR(-20001, 'Invalid hub');
  END IF;

  UPDATE Cliente c
  SET c.HUB_ID = wanted_hub
  WHERE c.codigo_interno = id_cliente;
END;

-- Comando para executar
BEGIN
  atribuir_hub_cliente(3, 'CT14');
END;

SELECT * FROM CLIENTE WHERE codigo_interno = 1;

-- ================================================================================

--  3. Quando o cliente efetua uma nota de encomenda pode indicar um hub, distinto do seu hub por
--  defeito, para proceder à recolha dos produtos encomendados. O hub indicado deve ser válido,
--  i.e., deve existir na tabela hub.

CREATE OR REPLACE TRIGGER hub_encomenda
BEFORE INSERT ON ENCOMENDA
FOR EACH ROW
DECLARE
    num_hubs INTEGER;
    default_hub_id VARCHAR;
BEGIN
    -- Vai buscar o default hub
    IF :new.hub_id IS NULL THEN
        SELECT c.hub_id INTO default_hub_id FROM Cliente c WHERE c.codigo_interno = :new.id_cliente;
        :new.hub_id := default_hub_id;
    END IF;

  -- Verifica que o hub indicado existe na tabela hub
    SELECT COUNT(*) INTO num_hubs FROM hub WHERE id_hub = :new.hub_id;
    IF num_hubs = 0 THEN
        RAISE_APPLICATION_ERROR(-20999, 'Hub inválido');
    END IF;

END;

INSERT INTO encomenda(registo_encomenda,estado,data_vencimento,valor_total,data_pagamento,id_cliente,hub_id)VALUES(TO_DATE('23/11/2022', 'DD/MM/YYYY'),'entregue',TO_DATE('05/12/2022', 'DD/MM/YYYY'),60.25,TO_DATE('07/12/2022', 'DD/MM/YYYY'),3,'CT14');
INSERT INTO encomenda(registo_encomenda,estado,data_vencimento,valor_total,data_pagamento,id_cliente,hub_id)VALUES(TO_DATE('23/11/2022', 'DD/MM/YYYY'),'entregue',TO_DATE('05/12/2022', 'DD/MM/YYYY'),60.25,TO_DATE('07/12/2022', 'DD/MM/YYYY'),4,NULL);

SELECT * FROM ENCOMENDA;

-------------------------------------------------------------------------------

