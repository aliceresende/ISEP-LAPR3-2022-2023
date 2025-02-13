CREATE OR REPLACE VIEW EvoluçãoMensalDeVendasPorTipoDeCultura AS
SELECT DISTINCT T.ANO,
                T.MES,
                TIPOPRODUTO,
                sum(QUANTIDADE) as QUANTIDADE,
                COALESCE(TO_CHAR(sum(QUANTIDADE) - (SELECT DISTINCT SUM(QUANTIDADE)
                                 FROM PRODUTO Child
                                          JOIN VENDA V3 on Child.IDPRODUTO = V3.IDPRODUTO
                                          JOIN TEMPO T2 on T2.IDTEMPO = V3.IDTEMPO
                                 WHERE Child.TIPOPRODUTO = Parent.TIPOPRODUTO
                                   AND T2.IDTEMPO = (SELECT IDTEMPO
                                                    FROM TEMPO T3
                                                    WHERE (T3.MES = T.MES - 1 AND T3.ANO = T.ANO)
                                                       OR (T3.ANO = T.ANO - 1 AND T3.MES = 12)
                                                    ORDER BY ANO DESC, MES FETCH FIRST ROW ONLY))),'There are no values to compare!') as COMPARISON
FROM PRODUTO Parent
         JOIN VENDA V2 on Parent.IDPRODUTO = V2.IDPRODUTO
         JOIN TEMPO T on T.IDTEMPO = V2.IDTEMPO
GROUP BY T.ANO, T.MES, TIPOPRODUTO
ORDER BY T.ANO, T.MES;