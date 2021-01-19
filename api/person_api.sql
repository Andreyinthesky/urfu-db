-- Person API
CREATE SEQUENCE person_index
  MINVALUE 1
  START WITH 1
  INCREMENT BY 1
  CACHE 20;
/

CREATE OR REPLACE PROCEDURE person_autoincrement(person_rec IN OUT persons%ROWTYPE) IS
  BEGIN
  SELECT person_index.nextval
    INTO person_rec.id
    FROM DUAL;
  END;
/

CREATE OR REPLACE PROCEDURE add_person(person_rec IN OUT persons%ROWTYPE) IS
  BEGIN
  person_autoincrement(person_rec);
  
  INSERT INTO persons
    VALUES person_rec;
  END;
/

CREATE OR REPLACE PROCEDURE update_person(person_rec IN OUT persons%ROWTYPE) IS
  temp_id NUMBER;
  BEGIN
    
  SELECT id INTO temp_id
    FROM persons
  WHERE id = person_rec.id;
  
  IF temp_id = NULL THEN
     RAISE_APPLICATION_ERROR(-20005, 'Отсутствует id.');
  END IF;

  UPDATE persons
    SET ROW = person_rec
  WHERE
    id = person_rec.id;
    
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20005, 'id не найден.');
    WHEN OTHERS THEN
      raise;
  END;
/

CREATE OR REPLACE PROCEDURE remove_person(person_id NUMBER) IS
  BEGIN
    DELETE FROM persons
    where id = person_id;
  END;
