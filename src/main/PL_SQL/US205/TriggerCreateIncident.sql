CREATE OR REPLACE TRIGGER insert_incident_on_late_payment
AFTER UPDATE ON payment_table
FOR EACH ROW
BEGIN
  IF :new.payment_date > SYSDATE AND :old.payment_date <= SYSDATE THEN
    INSERT INTO incident_table (client_id, payment_id, incident_date)
    VALUES (:new.client_id, :new.payment_id, SYSDATE);
  END IF;
END;


