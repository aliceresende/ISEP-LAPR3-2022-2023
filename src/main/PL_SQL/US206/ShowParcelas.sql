DECLARE
   c_codParcela PARCELA.COD_PARCELA%type;
   c_area PARCELA.AREA%type;
   c_designacao PARCELA.DESIGNACAO%type;
   CURSOR c_parcela is
      SELECT codParcela, area, designacao FROM parcela;
BEGIN
   OPEN c_parcela;
   LOOP
   FETCH c_parcela into c_codParcela, c_area, c_designacao;
      EXIT WHEN c_parcela%notfound;
      dbms_output.put_line(c_codParcela || ' ' || c_area || ' ' || c_designacao);
   END LOOP;
   CLOSE c_parcela;
END;