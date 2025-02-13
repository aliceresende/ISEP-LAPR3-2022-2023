SET SERVEROUTPUT ON
CREATE OR REPLACE VIEW EvolucaoUltimosCincoAnos AS

SELECT Prd.IdProducao, Tm.ANO, Tm.MES, IdSetor, produto.NOMEPRODUTO, QUANTIDADE,
       COALESCE(TO_CHAR(evolucaoProduto(IdSetor, produto.NOMEPRODUTO, Tm.ANO, Tm.MES)), 'No data available to make a comparison with the last month!') as EVOLUTION
FROM PRODUCAO Prd
         JOIN TEMPO Tm on Tm.IDTEMPO = Prd.IDTEMPO
         JOIN PRODUTO produto on produto.IdProduto = prd.IdProduto
WHERE Tm.ANO >= TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'), '9999') - 5;


SELECT *
FROM EVOLUCAOULTIMOSCINCOANOS Parent
WHERE IdSetor = 1
  AND nomeproduto = 'Carrot'
ORDER BY ANO, MES ASC;