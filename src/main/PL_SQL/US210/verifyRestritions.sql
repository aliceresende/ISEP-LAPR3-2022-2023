--Ponto 2 e 3--
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE verifica_restricoes_fator_producao(data_exe DATE) AS


    CURSOR c_restricoes IS
    SELECT
        p.designacao,
        oa.id_operacao,
        oa.data_planeada,
        oa.data_execucao,
        p.zona_geografica,
        fp.nome_comercial
    FROM
        parcela                 p,
        parcela_cultura         pc,
        parcela_fatordeproducao pfp,
        fatordeproducao         fp,
        operacaoagricola        oa,
        restricaofatorproducao  rfp
    WHERE
            p.cod_parcela = pc.parcelacod_parcela
        AND p.cod_parcela = pfp.cod_parcela
        AND fp.cod_fator_prod = pfp.cod_fator_prod
        AND pc.id_parcela_cultura = oa.parcela_culturaid_parcela_cultura
        AND fp.cod_fator_prod = rfp.fatordeproducaocod_fator_prod
        AND ( rfp.data_inicio <= oa.data_planeada
              AND rfp.data_fim >= oa.data_planeada
              OR rfp.data_inicio <= oa.data_execucao
              AND rfp.data_fim >= oa.data_execucao )
        AND p.zona_geografica = rfp.zona_geografica
        AND oa.id_operacao = oa.id_operacao
        AND fp.cod_fator_prod = fp.cod_fator_prod;

BEGIN
    -- Seleciona os dados das restrições que se aplicam à parcela na data especificada
    FOR c IN c_restricoes LOOP
        EXIT WHEN c_restricoes%notfound;

        IF c.data_execucao BETWEEN data_exe - 7 AND data_exe THEN
        dbms_output.put_line('Verifica-se uma semana antes da aplicação do fator de produção as restrições para ' || c.designacao || ' da operação agrícola' || c.id_operacao || 'para a zona' || c.zona_geografica || ' na data ' || to_char(c.data_execucao, 'DD/MM/YYYY') || '.');
        END IF;

        IF (c.data_execucao = data_exe) THEN
        dbms_output.put_line('Verificam-se restrições no momento do para ' || c.designacao || ' da operação agrícola' || c.id_operacao ||  'para a zona' || c.zona_geografica || ' na data ' || to_char(c.data_execucao, 'DD/MM/YYYY') || '.');
        END IF;

    -- Imprime os dados das restrições encontradas

    END LOOP;
END;

-----------------------------------------------------------------------------------------------------
BEGIN
verifica_restricoes_fator_producao('2022-10-02');
END;
-----------------------------------------------------------------------------------------------------
