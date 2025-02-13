
--- 1. Um utilizador pode listar os Setores de sua exploração agrícola ordenados por ordem decrescente da quantidade de produção
--- em uma determinada safra, medida em toneladas por hectare.

SELECT p.designacao, sum(c.quantidade_colheita) / p.area
FROM COLHEITA c, PARCELA_CULTURA d, Parcela p
        WHERE p.area IN (Select p.area from PARCELA p)
        AND p.cod_parcela = d.Parcelacod_parcela
        AND d.PARCELACOD_PARCELA = c.PARCELA_CULTURAPARCELACOD_PARCELA
        AND d.CULTURACOD_CULTURA = c.PARCELA_CULTURACULTURACOD_CULTURA
Group by p.designacao, p.area
Order by sum(c.quantidade_colheita) Desc;

//---------------------------------------------------------------------------------------------------------------

