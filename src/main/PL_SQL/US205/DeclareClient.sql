SET SERVEROUTPUT ON
DECLARE
    cId Number;
BEGIN
    cID := US205CreateClient('Claúdia','A',927134321,'claudia@isep.ipp.pt',31212789,1230, 2,3,3,'2022/12/04',1,2);
    DBMS_OUTPUT.PUT_LINE('New system user ID is ' || cId);
end;

-------------------------------------------------------------
BEGIN
US205UpdateLastYearInfo;
END;
-------------------------------------------------------------

SELECT * FROM CLIENTEVIEW;

-------------------------------------------------------------
BEGIN
UpdateIncidentDate;
END;
-------------------------------------------------------------