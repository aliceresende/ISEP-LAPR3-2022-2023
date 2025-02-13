
--- 2. Um utilizador pode listar os Setores de sua exploração agrícola ordenados por
--- ordem decrescente do lucro por hectare em uma determinada safra,
--- medido em K€ por hectare.

SELECT p.designacao, sum(prod.quantidade_produto * prod.preço_produto) / p.area
FROM COLHEITA c, PARCELA_CULTURA d, Parcela p, Produto prod
        WHERE p.area IN (Select p.area from PARCELA p)
        AND p.cod_parcela = d.Parcelacod_parcela
        AND d.PARCELACOD_PARCELA = c.PARCELA_CULTURAPARCELACOD_PARCELA
        AND d.CULTURACOD_CULTURA = c.PARCELA_CULTURACULTURACOD_CULTURA
        AND prod.colheitacod_colheita = c.cod_colheita
Group by p.designacao, p.area
Order by sum(prod.quantidade_produto * prod.preço_produto) Desc;

//================================================================================
