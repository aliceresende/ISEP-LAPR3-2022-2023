CREATE OR REPLACE PROCEDURE US205UpdateLastYearInfo as

    updateNumEncomenda number;
    updateValorTotal  number;

    CURSOR c_clients IS SELECT CODIGO_INTERNO FROM CLIENTE;

BEGIN
    FOR cur_cliente  IN c_clients
    LOOP
    EXIT WHEN c_clients%NOTFOUND;

    SELECT COUNT(*), SUM(E.VALOR_TOTAL) INTO updateNumEncomenda,updateValorTotal  FROM ENCOMENDA E, CLIENTE C
    WHERE E.ID_CLIENTE = C.CODIGO_INTERNO AND E.REGISTO_ENCOMENDA > SYSDATE - 365 AND  C.CODIGO_INTERNO = cur_cliente.CODIGO_INTERNO ;


    UPDATE CLIENTE SET NUMERO_ENCOMENDAS_ANUAL = updateNumEncomenda, VALOR_ENCOMENDAS_ANUAL = updateValorTotal WHERE CODIGO_INTERNO = cur_cliente.CODIGO_INTERNO;
     end LOOP;
end;