--Ponto 2 e 3--
SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER check_production_factor_restrictions
BEFORE INSERT OR UPDATE ON OperacaoAgricola_FatorDeProducao
FOR EACH ROW
WHEN (NEW.id_op_fator_prod>0)
DECLARE
    restriction_exists NUMBER;
BEGIN
    SELECT COUNT(*) INTO restriction_exists FROM Parcela p, Parcela_Cultura pc,Parcela_FatorDeProducao pfp, FatorDeProducao fp, OperacaoAgricola oa, RestricaoFatorProducao rfp
    WHERE p.cod_parcela = pc.Parcelacod_parcela
    AND p.cod_parcela = pfp.cod_parcela
    AND fp.cod_fator_prod=pfp.cod_fator_prod
    AND pc.id_parcela_cultura=oa.Parcela_Culturaid_parcela_cultura
    AND fp.cod_fator_prod=rfp.FatorDeProducaocod_fator_prod
    AND (rfp.data_inicio <= oa.data_planeada AND rfp.data_fim >= oa.data_planeada
         OR rfp.data_inicio <= oa.data_execucao AND rfp.data_fim >= oa.data_execucao)
    AND p.zona_geografica=rfp.zona_geografica
    AND :new.id_operacao=oa.id_operacao
    AND :new.cod_fator_prod=fp.cod_fator_prod;

    DBMS_OUTPUT.PUT_LINE('O Trigger foi ativado! Número de restrições ativas: '||restriction_exists);

    IF restriction_exists > 0 THEN
       RAISE_APPLICATION_ERROR(-20000, 'Operação Agrícola inválida: restrição detetada');
    END IF;
END;

-------------------------------------Insert com exceção-------------------------------------
Insert into operacaoagricola_fatordeproducao(id_operacao,cod_fator_prod,quantidade_aplicada,tipo_aplicacaoid_tipo_aplicacao)VALUES(2,1,12,2);
--------------------------------------------------------------------------------------------
-------------------------------------Insert sem exceção-------------------------------------
Insert into operacaoagricola_fatordeproducao(id_operacao,cod_fator_prod,quantidade_aplicada,tipo_aplicacaoid_tipo_aplicacao)VALUES(1,4,10,2);
--------------------------------------------------------------------------------------------
