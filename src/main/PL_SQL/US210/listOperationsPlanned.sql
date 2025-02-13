--Ponto 5--
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE listar_operacoes_planeadas (
    p_cod_parcela IN parcela.cod_parcela%TYPE,
    p_data_inicio IN DATE,
    p_data_fim    IN DATE
) AS

    CURSOR r_operacao IS
    SELECT
        o.id_operacao,
        t.tipo_operacao,
        o.data_planeada,
        p.designacao
    FROM
             operacaoagricola o
        INNER JOIN tipooperacaoagricola t ON o.tipooperacaoagricolaid_tipo_operacao = t.id_tipo_operacao
        INNER JOIN parcela_cultura      pc ON o.parcela_culturaid_parcela_cultura = pc.id_parcela_cultura
        INNER JOIN parcela              p ON pc.parcelacod_parcela = p.cod_parcela
    WHERE
            p.cod_parcela = p_cod_parcela
        AND o.data_planeada >= p_data_inicio
        AND o.data_execucao <= p_data_fim
    ORDER BY
        o.data_planeada;

BEGIN
    dbms_output.put_line('Operações planeadas na parcela '
                         || p_cod_parcela
                         || ' entre '
                         || to_char(p_data_inicio, 'DD/MM/YYYY')
                         || ' e '
                         || to_char(p_data_fim, 'DD/MM/YYYY')
                         || ':');

    FOR r IN r_operacao LOOP
        EXIT WHEN r_operacao%notfound;
-- Imprime os dados das operações encontradas
        dbms_output.put_line('ID operação: '
                             || r.id_operacao
                             || ' | tipo de operação: '
                             || r.tipo_operacao
                             || ' | Designação: '
                             || r.designacao);

    END LOOP;

END;

-------------------------------------------------------Executar------------------------------------------------------------
------------------Select para confirmar os dados------------------
--SELECT o.id_operacao, t.tipo_operacao, o.data_planeada, p.designacao
--FROM OperacaoAgricola o
--INNER JOIN TipoOperacaoAgricola t ON o.TipoOperacaoAgricolaid_tipo_operacao = t.id_tipo_operacao
--INNER JOIN Parcela_Cultura pc ON o.Parcela_Culturaid_parcela_cultura = pc.id_parcela_cultura
--INNER JOIN Parcela p ON pc.Parcelacod_parcela = p.cod_parcela
--WHERE p.cod_parcela = 4
--ORDER BY o.data_planeada;

Begin
listar_operacoes_planeadas(4, '2022-08-03', '2022-12-30');
end;

-----------------------------------------------------------------------------------------------------------------------------
