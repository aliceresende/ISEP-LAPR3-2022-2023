SET SERVEROUTPUT ON
DECLARE
    cId Number;
BEGIN
    cID := US206CreateParcela(102,'A');
    DBMS_OUTPUT.PUT_LINE('New parcela ID is ' || cId);
end;

INSERT INTO cultura(tipo_de_cultura,cultura,preco_cultura)VALUES('permanente','macieira',3.5);
INSERT INTO cultura(tipo_de_cultura,cultura,preco_cultura)VALUES('temporária','milho',2.1);
INSERT INTO cultura(tipo_de_cultura,cultura,preco_cultura)VALUES('permanente','laranjeira',5.5);
INSERT INTO cultura(tipo_de_cultura,cultura,preco_cultura)VALUES('permanente','pereira',2.5);