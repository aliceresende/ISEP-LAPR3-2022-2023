CREATE TABLE Processoleitura(
    processo_id integer GENERATED AS IDENTITY,
    num_lidos integer,
    num_inseridos integer,
    PRIMARY KEY (processo_id));
CREATE TABLE Leituraerros(
    leituraerros_id integer GENERATED AS IDENTITY,
    sensor_id_cod integer,
    num_erros integer NOT NULL,
    Processoleitura_cod integer NOT NULL,
    PRIMARY KEY (leituraerros_id));
CREATE TABLE input_sensor(
    input varchar(25),
    PRIMARY KEY(input));
    
ALTER TABLE Leituraerros ADD CONSTRAINT FKerro904520 FOREIGN KEY (sensor_id_cod) REFERENCES Sensor (id_sensor);
ALTER TABLE Leituraerros ADD CONSTRAINT FKerro954520 FOREIGN KEY (Processoleitura_cod) REFERENCES Processoleitura (processo_id);


DROP TABLE Leituraerros CASCADE CONSTRAINTS;
DROP TABLE Processoleitura CASCADE CONSTRAINTS;
DROP TABLE input_sensor CASCADE CONSTRAINTS;


INSERT INTO input_sensor VALUES('00001tp100001121220221340');
INSERT INTO input_sensor VALUES('00001tp100001121220221348');
INSERT INTO input_sensor VALUES('00001tp100001121220221349');



CREATE OR REPLACE PROCEDURE add_error(sensorID integer)
as
    numm integer;
BEGIN
    SELECT COUNT (*) INTO numm FROM LEITURAERROS WHERE sensor_id_cod=sensorID;
    IF (numm = 0) THEN
                INSERT INTO LEITURAERROS(sensor_id_cod, num_erros, processoleitura_cod) VALUES(sensorID, 1, (SELECT MAX(processo_id)
                FROM PROCESSOLEITURA));
            ELSE
                UPDATE LEITURAERROS
                SET num_erros=num_erros+1
                WHERE sensor_id_cod=sensorID;
            END IF;
END;





CREATE OR REPLACE FUNCTION process_reader RETURN INTEGER
IS
    data varchar(25);
    sensorID integer;
    tipo varchar(2);
    valorREF integer;
    valorRED integer;
    sensortxt varchar(5);
    tipoTXT varchar(2);
    valorref_txt varchar(3);
    valorred_txt varchar(3);
    dia varchar(2);
    mes varchar(2);
    ano varchar(4);
    hora varchar(2);
    minuto varchar(2);
    dt varchar(16);
    dt_final date;
    CURSOR cc IS SELECT * FROM INPUT_SENSOR; 
    exist integer;
    res boolean;
    count_inserido integer;
    count_nao_inserido integer;
    count_lido integer;
BEGIN
    count_inserido:=0;
    count_lido:=0;
    INSERT INTO PROCESSOLEITURA(num_lidos, num_inseridos) VALUES(null, null);
    OPEN cc;
    LOOP
    FETCH cc INTO data;
    IF (CC%NOTFOUND) THEN
        dbms_output.put_line('vazio');
    END IF;
    EXIT WHEN cc%notfound;
    
        sensortxt:=SUBSTR(data, 1, 5);
        sensorID:=TO_NUMBER(sensortxt);
            
        
        tipotxt := SUBSTR(data, 6, 2);
        SELECT COUNT(ID_TIPO_SENSOR) INTO exist FROM TIPOSENSOR WHERE tipo_sensor=tipoTXT;
        IF exist  = 0 THEN
            add_error(sensorID);
            CONTINUE;
        ELSE
            SELECT TIPO_SENSOR INTO tipo FROM TIPOSENSOR WHERE tipo_sensor=tipoTXT;
        END IF;
        
        valorred_txt:=SUBSTR(data, 8, 3);
        valorRED:=TO_NUMBER(valorred_txt);
        
        
        valorref_txt:=SUBSTR(data, 11, 3);
        valorREF:=TO_NUMBER(valorref_txt);
        
        dia:=SUBSTR(data, 14, 2);
        mes:=SUBSTR(data, 16, 2);
        ano:=SUBSTR(data, 18, 4);
        hora:=SUBSTR(data, 22, 2);
        minuto:=SUBSTR(data, 24, 2);
        dt:=(dia||'-'||mes||'-'||ano||' '||hora||':'||minuto);
        dt_final:=TO_DATE(dt, 'DD-MM-YYYY HH24:MI');
        
        
        res:=check_insert(sensorID, valorRED, valorREF, dt_final, tipo);
        
        
        IF res=TRUE THEN
            INSERT INTO LEITURA(valor, instante_leitura, sensor_id) VALUES(valorRED, dt_final, sensorID);
            count_inserido:=count_inserido+1;
            count_lido:=count_lido+1;
            DELETE FROM INPUT_SENSOR
            WHERE input=data;
        END IF;
        
    END LOOP;
    CLOSE cc;
        UPDATE PROCESSOLEITURA
        SET num_lidos=count_lido, num_inseridos=count_inserido
        WHERE processo_id=(SELECT MAX(processo_id) FROM PROCESSOLEITURA);
        
        return 1;
--
END;

CREATE OR REPLACE PROCEDURE leitura_report
AS 
    exist integer;
    CURSOR cc IS SELECT sensor_id_cod, num_erros FROM LEITURAERROS;
    sensorcod integer;
    erros integer;
BEGIN
OPEN cc;
    --OPEN cc for SELECT sensor_id_cod, num_erros FROM LEITURAERROS;
    dbms_output.put_line('Sensor Process report:');
    SELECT num_lidos INTO exist FROM PROCESSOLEITURA;
    dbms_output.put_line('nº de valores lidos: '||exist);
    SELECT num_inseridos INTO exist FROM PROCESSOLEITURA;
    dbms_output.put_line('nº de valores inseridos: '||exist);
    SELECT SUM(num_erros) INTO exist FROM LEITURAERROS;
    dbms_output.put_line('nº de erros: '||exist);
    LOOP
    FETCH cc INTO sensorcod, erros;
    EXIT WHEN cc%notfound;
        dbms_output.put_line('sensor nº: '||sensorcod|| ' -> nº de erros: ' ||erros);
    END LOOP;
    CLOSE cc;

END;

CREATE OR REPLACE FUNCTION check_insert(sen_id integer, val integer, val_ref integer, dt date, tp varchar) RETURN BOOLEAN
IS
    res boolean;
    sen_count integer;
    tp_count integer;
    val_ref_count integer;
BEGIN
    res:= TRUE;
    SELECT COUNT(id_sensor) INTO sen_count FROM SENSOR WHERE id_sensor=sen_id;
    SELECT COUNT(id_tipo_sensor) INTO tp_count FROM TIPOSENSOR WHERE tipo_sensor=tp;
    IF(sen_count=0 OR tp_count=0 OR val_ref>100 OR val>100) THEN
        res:=FALSE;
    END IF;
    return res;
END;



DECLARE
    result integer;
BEGIN
    result:=process_reader();
    leitura_report;
END;
