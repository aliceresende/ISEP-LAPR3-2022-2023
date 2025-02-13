--Ponto 4--
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE listar_restricoes (
    p_cod_parcela IN parcela.cod_parcela%TYPE,
    p_data        IN DATE
) AS

    CURSOR c_restricoes IS
    SELECT
        r.zona_geografica,
        r.data_inicio,
        r.data_fim,
        f.nome_comercial,
        f.formulacao,
        p.designacao
    FROM
             restricaofatorproducao r
        INNER JOIN fatordeproducao         f ON r.fatordeproducaocod_fator_prod = f.cod_fator_prod
        INNER JOIN parcela_fatordeproducao pf ON f.cod_fator_prod = pf.cod_fator_prod
        INNER JOIN parcela                 p ON pf.cod_parcela = p.cod_parcela
    WHERE
            p.cod_parcela = p_cod_parcela
        AND r.data_inicio <= p_data
        AND r.data_fim >= p_data;

BEGIN
    -- Seleciona os dados das restrições que se aplicam à parcela na data especificada
    FOR c IN c_restricoes LOOP
        EXIT WHEN c_restricoes%notfound;

    -- Imprime os dados das restrições encontradas
        dbms_output.put_line('Restrições para '
                             || c.designacao
                             || ' na data '
                             || to_char(p_data, 'DD/MM/YYYY')
                             || ':');

        dbms_output.put_line('Fator de produção: '
                             || c.nome_comercial
                             || ' ('
                             || c.formulacao
                             || ')');

        dbms_output.put_line('Zona geográfica: ' || c.zona_geografica);
        dbms_output.put_line('Data de início: '
                             || to_char(c.data_inicio, 'DD/MM/YYYY'));
        dbms_output.put_line('Data de fim: '
                             || to_char(c.data_fim, 'DD/MM/YYYY'));
        dbms_output.put_line('');
        dbms_output.put_line('--------------------------------------');
        dbms_output.put_line('');
    END LOOP;
END;

-------------------------------------------------------Executar------------------------------------------------------------
------------------Select para confirmar os dados------------------
--SELECT r.zona_geografica, r.data_inicio, r.data_fim, f.nome_comercial, f.formulacao, p.designacao
--FROM RestricaoFatorProducao r
--INNER JOIN FatorDeProducao f ON r.FatorDeProducaocod_fator_prod = f.cod_fator_prod
--INNER JOIN Parcela_FatorDeProducao pf ON f.cod_fator_prod = pf.cod_fator_prod
--INNER JOIN Parcela p ON pf.cod_parcela = p.cod_parcela
--WHERE p.cod_parcela = 4 AND r.data_inicio <= '2022-09-13' AND r.data_fim >= '2022-09-13';

Begin
listar_restricoes(4,'2022-09-13');
end;
-----------------------------------------------------------------------------------------------------------------------------
