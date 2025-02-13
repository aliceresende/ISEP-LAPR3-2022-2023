SET SERVEROUTPUT ON
CREATE OR REPLACE FUNCTION US205CreateClient(nomeCliente IN CLIENTE.NOME%type, nivelCliente IN CLIENTE.NIVEL%type,
                                                clienteTelefone IN CLIENTE.TELEFONE%type,
                                                clienteEmail IN CLIENTE.EMAIL%type,
                                                clienteNIF IN CLIENTE.NIF%type,
                                                clientePlafond IN CLIENTE.PLAFOND%type DEFAULT 5000,
                                                clienteNIncidentes IN CLIENTE.NUMERO_INCIDENTE%type DEFAULT 0,
                                                clienteNEncomendasAnuais IN CLIENTE.NUMERO_ENCOMENDAS_ANUAL%type DEFAULT 0,
                                                clienteValorEncomendasAnuais IN CLIENTE.VALOR_ENCOMENDAS_ANUAL%type DEFAULT 0,
                                                clienteUltimoIncidente IN CLIENTE.DATA_INCIDENTE%type,
                                                clienteMoradaEntrega IN CLIENTE.ID_MORADA_ENTREGA%type,
                                                clienteMoradaCorrespondencia IN CLIENTE.ID_MORADA_CORRESPONDENCIA%type) RETURN CLIENTE.CODIGO_INTERNO%type AS

    idCliente          CLIENTE.CODIGO_INTERNO%type;

BEGIN

    if (COALESCE(clienteMoradaEntrega, clienteMoradaCorrespondencia) IS NULL) then
        RAISE_APPLICATION_ERROR(-20003, 'Os códigos postais não podem ser nulos');
    end if;


    INSERT INTO CLIENTE(NOME,NIVEL,TELEFONE,EMAIL,NIF,PLAFOND, NUMERO_INCIDENTE,NUMERO_ENCOMENDAS_ANUAL,VALOR_ENCOMENDAS_ANUAL,DATA_INCIDENTE,ID_MORADA_ENTREGA,ID_MORADA_CORRESPONDENCIA)
    VALUES (nomeCliente,nivelCliente,clienteTelefone,clienteEmail,clienteNIF,clientePlafond,clienteNIncidentes,clienteNEncomendasAnuais,clienteValorEncomendasAnuais,clienteUltimoIncidente,clienteMoradaEntrega,clienteMoradaCorrespondencia)
    returning CODIGO_INTERNO into idCliente;
    return idCliente;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20001, 'Email, NIF ou Telefone já existente!');
        return null;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro :(  ' || SQLCODE || ' - ' || SQLERRM);
end;

