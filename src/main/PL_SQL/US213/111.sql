CREATE OR REPLACE PROCEDURE adaptar_operacoes ( estado_op VARCHAR2, idOp IN operacaoAgricola.id_operacao%TYPE, dataPlaneada  IN operacaoAgricola.data_planeada%TYPE,
dataExecucao IN operacaoAgricola.data_execucao%TYPE, tipoOperacao IN operacaoAgricola.TipoOperacaoAgricolaid_tipo_operacao%TYPE,
cultura IN operacaoAgricola.Parcela_Culturaid_parcela_cultura%TYPE) AS

BEGIN

    IF (idOp IS NULL) THEN
       RAISE_APPLICATION_ERROR(-20000, 'Operação Agrícola inválida: restrição detetada');
    END IF;

    IF ( estado_op <> 'cancelar') THEN
        UPDATE OperacaoAgricola
        SET estado = estado_op
        WHERE op.id_operacao = idOp;
    ELSIF ( estado_op <> 'atualizar') THEN
        UPDATE OperacaoAgricola
        SET estado = 'Atualizado',
        data_planeada = NVL(dataPlaneada, data_planeada),
       data_execucao = NVL(dataExecucao, data_execucao),
        TipoOperacaoAgricolaid_tipo_operacao = NVL(tipoOperacao, TipoOperacaoAgricolaid_tipo_operacao),
        Parcela_Culturaid_parcela_cultura = NVL(cultura, Parcela_Culturaid_parcela_cultura)
        WHERE id_operacao = idOp;
    END IF;

END;