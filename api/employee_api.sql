-- Employee API
CREATE SEQUENCE emp_index
  MINVALUE 1
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

CREATE OR REPLACE PROCEDURE autoincrement(emp_rec IN OUT employees%ROWTYPE) IS
  BEGIN
  SELECT emp_index.nextval
    INTO emp_rec.id
    FROM DUAL;
  END;
/

CREATE OR REPLACE PROCEDURE add_employee(emp_rec IN OUT employees%ROWTYPE) IS
  temp_id NUMBER;

  BEGIN
  autoincrement(emp_rec);
  SELECT id_person INTO temp_id
    FROM employees
  WHERE id_person = emp_rec.id_person;
  
  IF temp_id = emp_rec.id_person THEN
     RAISE_APPLICATION_ERROR(-20005, 'Человек не может работать более чем на одной должности.');
  END IF;

  INSERT INTO employees
    (id,
     id_person,
     tabel_number,
     post)
  VALUES
    (emp_rec.id,
     emp_rec.id_person,
     emp_rec.tabel_number,
     emp_rec.post);
     
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INSERT INTO employees
          (id,
           id_person,
           tabel_number,
           post)
        VALUES
          (emp_rec.id,
           emp_rec.id_person,
           emp_rec.tabel_number,
           emp_rec.post);
    WHEN OTHERS THEN
      raise;
  END;
/

CREATE OR REPLACE PROCEDURE update_employee(emp_rec IN OUT employees%ROWTYPE) IS
  temp_id NUMBER;
  BEGIN
    
  SELECT id INTO temp_id
    FROM employees
  WHERE id = emp_rec.id;
  
  IF temp_id = NULL THEN
     RAISE_APPLICATION_ERROR(-20005, 'Отсутствует id.');
  END IF;

  UPDATE employees
    SET id_person = emp_rec.id_person,
    tabel_number = emp_rec.tabel_number,
    post = emp_rec.post
  WHERE
    id = emp_rec.id;
    
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20005, 'id не найден.');
    WHEN OTHERS THEN
      raise;
  END;
/

CREATE OR REPLACE PROCEDURE remove_employee(emp_id NUMBER) IS
  BEGIN
    DELETE FROM employees
    where id = emp_id;
  END;