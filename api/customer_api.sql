-- customer API
CREATE SEQUENCE customer_index
  MINVALUE 1
  START WITH 1
  INCREMENT BY 1
  CACHE 20;
/

CREATE OR REPLACE PROCEDURE customer_autoincrement(customer_rec IN OUT customers%ROWTYPE) IS
  BEGIN
  SELECT customer_index.nextval
    INTO customer_rec.id
    FROM DUAL;
  END;
/
