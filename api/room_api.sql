-- Room API
CREATE SEQUENCE room_index
  MINVALUE 1
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

CREATE OR REPLACE PROCEDURE room_autoincrement(room_rec IN OUT rooms%ROWTYPE) IS
  BEGIN
  SELECT room_index.nextval
    INTO room_rec.id
    FROM DUAL;
  END;
/

CREATE OR REPLACE PROCEDURE add_room(room_rec IN OUT rooms%ROWTYPE) IS
  BEGIN
  room_autoincrement(room_rec);
  
  INSERT INTO rooms(id, id_type, room_number)
    VALUES(room_rec.id, room_rec.id_type, room_rec.room_number);
  
  END;
/

CREATE OR REPLACE PROCEDURE update_room(room_rec IN OUT rooms%ROWTYPE) IS
  temp_id NUMBER;
  BEGIN
    
  SELECT id INTO temp_id
    FROM rooms
  WHERE id = room_rec.id;
  
  IF temp_id = NULL THEN
     RAISE_APPLICATION_ERROR(-20005, '����������� id.');
  END IF;

  UPDATE rooms
    SET room_number = room_rec.room_number,
    id_type = room_rec.id_type
  WHERE
    id = room_rec.id;
    
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20005, 'id �� ������.');
    WHEN OTHERS THEN
      raise;
  END;
/

CREATE OR REPLACE PROCEDURE remove_room(room_id NUMBER) IS
  BEGIN
    DELETE FROM rooms
    where id = room_id;
  END;
