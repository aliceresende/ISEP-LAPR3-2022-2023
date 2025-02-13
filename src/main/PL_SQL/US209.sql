SET SERVEROUTPUT ON
INSERT INTO MORADA VALUES(1, '4795-876', 'rua do agrelo', 123, '12/12/21');
INSERT INTO CLIENTE(nome, nivel, telefone, email, nif, plafond, numero_encomendas_anual, valor_encomendas_anual, numero_incidente, data_incidente, id_morada_entrega, id_morada_correspondencia)
VALUES('goncalo', null, 936538885, 'silvagoncalo463@gmail.com', 123456789, 2000,null, null, null, null, 1, 1);
INSERT INTO ENCOMENDA(registo_encomenda, estado, data_vencimento, valor_total, id_cliente)VALUES(SYSDATE, 'POR PAGAR', SYSDATE+1, 40, 1);
INSERT INTO ENCOMENDA(registo_encomenda, estado, data_vencimento, valor_total, id_cliente)VALUES(SYSDATE, 'POR PAGAR', SYSDATE+2, 19, 1);


CREATE OR REPLACE FUNCTION create_encomenda( num encomenda.valor_total%type, cliente encomenda.id_cliente%type, mora varchar, dt_entrega entrega.data%type) RETURN INTEGER
IS
encomenda_num encomenda.num_encomenda%type;
dt DATE;
vencimento encomenda.data_vencimento%type;
morada_cliente integer;
plafond_check number(10,2);
plafond_actual number(10,2);
resul integer;
BEGIN

    SELECT sum(valor_total) INTO plafond_check FROM ENCOMENDA WHERE id_cliente=cliente;
    SELECT plafond INTO plafond_actual FROM CLIENTE WHERE codigo_interno=cliente;
    IF(plafond_check>=plafond_actual)THEN
        RETURN NULL;
    END IF;
dt:=SYSDATE;
vencimento:=dt+1;

    IF mora = 'default'THEN
        SELECT id_morada_entrega INTO morada_cliente FROM CLIENTE WHERE codigo_interno=cliente;
      INSERT INTO ENCOMENDA(registo_encomenda, estado, data_vencimento, valor_total, id_cliente)VALUES(dt, 'POR PAGAR', vencimento, num, cliente)
      RETURNING NUM_ENCOMENDA INTO resul;
      SELECT max(num_encomenda)INTO encomenda_num FROM ENCOMENDA;
      INSERT INTO ENTREGA(data, estado_entrega, num_encomenda, id_morada)VALUES(dt_entrega, 'Não Entregue', encomenda_num, morada_cliente);

    ELSE
      INSERT INTO ENCOMENDA(registo_encomenda, estado, data_vencimento, valor_total, id_cliente)VALUES(dt, 'POR PAGAR', vencimento, num, cliente)
      RETURNING NUM_ENCOMENDA INTO resul;
      SELECT max(num_encomenda)INTO encomenda_num FROM ENCOMENDA;
      INSERT INTO ENTREGA(data, estado_entrega, num_encomenda, id_morada)VALUES(dt_entrega, 'Não entregue', encomenda_num, mora);

    END IF;

    RETURN resul;
END;




CREATE OR REPLACE FUNCTION list_estado (estate encomenda.estado%type) RETURN varchar
IS
CURSOR list IS SELECT * FROM ENCOMENDA WHERE estado=estate;
id_enc encomenda.num_encomenda%type;
registo encomenda.registo_encomenda%type;
state encomenda.estado%type;
vencimento encomenda.data_vencimento%type;
valor encomenda.valor_total%type;
pagamento encomenda.data_pagamento%type;
cliente encomenda.id_cliente%type;
BEGIN
OPEN list;
LOOP
    FETCH list INTO id_enc,registo,state, vencimento, valor, pagamento, cliente;
    EXIT WHEN list%notfound;
        dbms_output.put_line('NUM_ENCOMENDA >'||id_enc||'-REGISTO_ENCOMENDA >'||registo||'-ESTADO >'|| state ||'-DATA_VENCIMENTO >'||vencimento||'-VALOR_TOTAL >'||valor||
        '-DATA_PAGAMENTO >'||pagamento||'ID_CLIENTE'||cliente);
    END LOOP;
    CLOSE list;
    RETURN 'sucesso';
END;

CREATE OR REPLACE FUNCTION list_id (id_num encomenda.num_encomenda%type) RETURN varchar
IS
CURSOR list IS SELECT * FROM ENCOMENDA WHERE num_encomenda=id_num;
enc_num encomenda.num_encomenda%type;
estate encomenda.estado%type;
registo encomenda.registo_encomenda%type;
vencimento encomenda.data_vencimento%type;
valor encomenda.valor_total%type;
pagamento encomenda.data_pagamento%type;
cliente encomenda.id_cliente%type;
BEGIN
OPEN list;
LOOP
    FETCH list INTO enc_num,registo,estate, vencimento, valor, pagamento, cliente;
    EXIT WHEN list%notfound;
        dbms_output.put_line('NUM_ENCOMENDA >'||enc_num||'-REGISTO_ENCOMENDA >'||registo||'-ESTADO >'|| estate ||'-DATA_VENCIMENTO >'||vencimento||'-VALOR_TOTAL >'||valor||
        '-DATA_PAGAMENTO >'||pagamento||'ID_CLIENTE'||cliente);
    END LOOP;
    CLOSE list;
    RETURN 'sucesso';
END;

CREATE OR REPLACE FUNCTION list_date (dt encomenda.registo_encomenda%type) RETURN varchar
IS
CURSOR list IS SELECT * FROM ENCOMENDA WHERE registo_encomenda=dt;
enc_num encomenda.num_encomenda%type;
estate encomenda.estado%type;
registo encomenda.registo_encomenda%type;
vencimento encomenda.data_vencimento%type;
valor encomenda.valor_total%type;
pagamento encomenda.data_pagamento%type;
cliente encomenda.id_cliente%type;
BEGIN
OPEN list;
LOOP
    FETCH list INTO enc_num,registo,estate, vencimento, valor, pagamento, cliente;
    EXIT WHEN list%notfound;
        dbms_output.put_line('NUM_ENCOMENDA >'||enc_num||'-REGISTO_ENCOMENDA >'||registo||'-ESTADO >'|| estate ||'-DATA_VENCIMENTO >'||vencimento||'-VALOR_TOTAL >'||valor||
        '-DATA_PAGAMENTO >'||pagamento||'ID_CLIENTE'||cliente);
    END LOOP;
    CLOSE list;
    RETURN 'sucesso';
END;

CREATE OR REPLACE FUNCTION list_cliente (clienteNum encomenda.id_cliente%type) RETURN varchar
IS
CURSOR list IS SELECT * FROM ENCOMENDA WHERE id_cliente=clienteNum;
enc_num encomenda.num_encomenda%type;
estate encomenda.estado%type;
registo encomenda.registo_encomenda%type;
vencimento encomenda.data_vencimento%type;
valor encomenda.valor_total%type;
pagamento encomenda.data_pagamento%type;
cliente encomenda.id_cliente%type;
BEGIN
OPEN list;
LOOP
    FETCH list INTO enc_num,registo,estate, vencimento, valor, pagamento, cliente;
    EXIT WHEN list%notfound;
        dbms_output.put_line('NUM_ENCOMENDA >'||enc_num||'-REGISTO_ENCOMENDA >'||registo||'-ESTADO >'|| estate ||'-DATA_VENCIMENTO >'||vencimento||'-VALOR_TOTAL >'||valor||
        '-DATA_PAGAMENTO >'||pagamento||'ID_CLIENTE'||cliente);
    END LOOP;
    CLOSE list;
    RETURN 'sucesso';
END;

CREATE OR REPLACE FUNCTION update_encomenda(e encomenda.num_encomenda%type) RETURN integer
IS
BEGIN
    UPDATE ENCOMENDA
    SET estado='PAGA', data_pagamento=SYSDATE
    WHERE num_encomenda=e;
    RETURN e;
END;

DECLARE

num encomenda.valor_total%type;
cliente encomenda.id_cliente%type;
mora varchar(7);
returno varchar(7);
resul integer;
dt_entrega entrega.data%type;
int_return integer;
res varchar(7);
BEGIN

mora:='default';
cliente:=1;
dt_entrega:='07/12/22';
num:=39;
resul:=create_encomenda(num, cliente, mora, dt_entrega);
returno:=list_id(1);
returno:=list_date(dt_entrega);
returno:=list_estado('POR PAGAR');
returno:=list_cliente(cliente);
int_return:=update_encomenda(1);
returno:=list_estado('PAGA');
END;