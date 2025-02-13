CREATE OR REPLACE FUNCTION US206CreateParcela(area IN PARCELA.AREA%type, designacao IN PARCELA.DESIGNACAO%type) RETURN PARCELA.COD_PARCELA%type AS

    choosenArea        PARCELA.AREA%type;
    idParcela          PARCELA.COD_PARCELA%type;

BEGIN

    if (area IS NULL) then
        RAISE_APPLICATION_ERROR(-20003, 'A area não pode ser nula');
    end if;
    choosenArea := area;

    INSERT INTO PARCELA(AREA,DESIGNACAO)
    VALUES (area,designacao)
    returning COD_PARCELA into idParcela;
    return idParcela;

end;