INSERT INTO FICHATECNICA(fornecedor)VALUES('GARDENlda');

INSERT INTO CATEGORIA(categoria) VALUES('usado como fertilizante');
INSERT INTO ELEMENTO(substancia, unidade, categoriacod_categora) VALUES('carbono de origem biológica(TOC)', 35, 1);
INSERT INTO ELEMENTO(substancia, unidade, categoriacod_categora) VALUES('MATÉRIA ORGÂNICA)', 60, 1);
INSERT INTO FICHATECNICA_ELEMENTO(fichatecnicacod_ficha_tecnica, elementocod_elemento, quantidade_elemento)VALUES(1,1,35);

CREATE OR REPLACE FUNCTION create_fichatecnica (f fichatecnica.fornecedor%type,
 ec fichatecnica_elemento.elementocod_elemento%type, q fichatecnica_elemento.quantidade_elemento%type) RETURN integer
IS
 insert_id integer;
  fc fichatecnica_elemento.fichatecnicacod_ficha_tecnica%type;
BEGIN
    INSERT INTO FICHATECNICA(fornecedor)VALUES(f);
    SELECT MAX(cod_ficha_tecnica) INTO fc FROM FICHATECNICA;
    INSERT INTO FICHATECNICA_ELEMENTO(fichatecnicacod_ficha_tecnica, elementocod_elemento, quantidade_elemento)VALUES(fc,ec,q)
    RETURNING fichatecnicacod_ficha_tecnica INTO insert_id;
    RETURN insert_id;
END;

CREATE OR REPLACE FUNCTION update_ft_cod(ft_id fichatecnica_elemento.fichatecnicacod_ficha_tecnica%type, fc fichatecnica_elemento.fichatecnicacod_ficha_tecnica%type)RETURN integer
IS

BEGIN
    UPDATE FICHATECNICA_ELEMENTO
    SET fichatecnicacod_ficha_tecnica=fc
    WHERE fichatecnicacod_ficha_tecnica=ft_id;
    RETURN fc;
END;

CREATE OR REPLACE FUNCTION update_elem_cod(ft_id fichatecnica_elemento.fichatecnicacod_ficha_tecnica%type, ec fichatecnica_elemento.elementocod_elemento%type)RETURN integer
IS

BEGIN
    UPDATE FICHATECNICA_ELEMENTO
    SET elementocod_elemento=ec
    WHERE fichatecnicacod_ficha_tecnica=ft_id;
    RETURN ec;
END;


CREATE OR REPLACE FUNCTION update_q(ft_id fichatecnica_elemento.fichatecnicacod_ficha_tecnica%type, q fichatecnica_elemento.quantidade_elemento%type)RETURN varchar
IS

BEGIN
    UPDATE FICHATECNICA_ELEMENTO
    SET quantidade_elemento=q
    WHERE fichatecnicacod_ficha_tecnica=ft_id;
    RETURN q;
END;

CREATE OR REPLACE FUNCTION list_ft return sys_refcursor
IS
    list SYS_REFCURSOR;
BEGIN
    OPEN list for SELECT fe.fichatecnicacod_ficha_tecnica, ft.fornecedor, fe.elementocod_elemento, el.substancia,
    el.unidade FROM FICHATECNICA_ELEMENTO fe INNER JOIN FICHATECNICA  ft ON fe.fichatecnicacod_ficha_tecnica=ft.cod_ficha_tecnica
    INNER JOIN ELEMENTO  el ON fe.elementocod_elemento=el.cod_elemento;
    RETURN list;
END;

DECLARE
    f fichatecnica.fornecedor%type;
    c categoria.categoria%type;
    ec fichatecnica_elemento.elementocod_elemento%type;
    q fichatecnica_elemento.quantidade_elemento%type;
    id_insert integer;
    id_change integer;
    list SYS_REFCURSOR;
    s elemento.substancia%type;
    u elemento.unidade%type;
BEGIN
    SELECT MAX(cod_elemento) INTO ec FROM ELEMENTO;
    id_insert:=create_fichatecnica('Guanito', ec, q);
    dbms_output.put_line(id_insert);
    list:=list_ft();
    LOOP
    FETCH list INTO id_insert, f, ec, s, u;
    EXIT WHEN list%notfound;
        dbms_output.put_line('fichatecnica_id >'||id_insert||'||fornecedor >'||f||'||elemento_cod >'||ec||'||susbstancia >'||s||'||unidade >'||u);
    END LOOP;
    SELECT MAX(cod_elemento)-1 INTO id_insert FROM ELEMENTO;
    CLOSE list;
END;