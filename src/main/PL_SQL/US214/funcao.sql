SET SERVEROUTPUT ON
              CREATE OR REPLACE FUNCTION evolucaoProduto(setor IN PRODUCAO.IDSETOR%type, prod IN PRODUTO.NOMEPRODUTO%type, a IN TEMPO.ANO%type, m IN TEMPO.MES%type)

 RETURN NUMBER AS

    tmpM          NUMBER(2, 0);
    tmpA          NUMBER(4, 0);
    quantidadeMesAtual NUMBER(10, 0);
    quantidadeMesPassado   NUMBER(10, 0);
    evolucao       NUMBER(10,0);


begin
    SELECT QUANTIDADE
    into quantidadeMesAtual
    FROM PRODUCAO
             JOIN PRODUTO P on P.IDPRODUTO = PRODUCAO.IDPRODUTO
             JOIN TEMPO T on T.IDTEMPO = PRODUCAO.IDTEMPO
    WHERE IDSETOR = setor
      AND P.NOMEPRODUTO = prod
      AND T.ANO = a
      AND T.MES = m;
    tmpA := a;
    tmpM := m - 1;
    if (tmpM <= 0) THEN
        tmpM := 12;
        tmpA := tmpA - 1;
    end if;
    SELECT QUANTIDADE
    into quantidadeMesPassado
    FROM PRODUCAO
             JOIN PRODUTO P on P.IDPRODUTO = PRODUCAO.IDPRODUTO
             JOIN TEMPO T on T.IDTEMPO = PRODUCAO.IDTEMPO
    WHERE IDSETOR = setor
      AND P.NOMEPRODUTO = prod
      AND T.ANO = tmpA
      AND T.MES = tmpM;
      evolucao :=quantidadeMesAtual - quantidadeMesPassado;
      if(evolucao < 0)THEN
        DBMS_OUTPUT.PUT_LINE('Client does not had incidents in the past 12 months ');
        ELSE
        return evolucao;
       end if;

       EXCEPTION
    WHEN NO_DATA_FOUND THEN
        return NULL;

end;