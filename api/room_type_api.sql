-- RoomType API
CREATE SEQUENCE room_type_index
  MINVALUE 1
  START WITH 1
  INCREMENT BY 1
  CACHE 20;
/

CREATE OR REPLACE PROCEDURE room_type_autoincrement(room_type_rec IN OUT room_types%ROWTYPE) IS
  BEGIN
  SELECT room_type_index.nextval
    INTO room_type_rec.id
    FROM DUAL;
  END;
/

CREATE OR REPLACE PROCEDURE add_room_type(room_type_rec IN OUT room_types%ROWTYPE) IS
  temp_id NUMBER;

  BEGIN
  room_type_autoincrement(room_type_rec);
  
  INSERT INTO room_types(id, name, place_count, base_price)
    VALUES(room_type_rec.id, room_type_rec.name, room_type_rec.place_count, room_type_rec.base_price);
  
  END;
/

CREATE OR REPLACE PROCEDURE update_room_type(room_type_rec IN OUT room_types%ROWTYPE) IS
  temp_id NUMBER;
  BEGIN
    
  SELECT id INTO temp_id
    FROM room_types
  WHERE id = room_type_rec.id;
  
  IF temp_id = NULL THEN
     RAISE_APPLICATION_ERROR(-20005, '����������� id.');
  END IF;

  UPDATE room_types
    SET name = room_type_rec.name,
    place_count = room_type_rec.place_count,
    base_price = room_type_rec.base_price
  WHERE
    id = room_type_rec.id;
    
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20005, 'id �� ������.');
    WHEN OTHERS THEN
      raise;
  END;
/

CREATE OR REPLACE PROCEDURE remove_room_type(room_type_id NUMBER) IS
  BEGIN
    DELETE FROM room_types
    where id = room_type_id;
  END;
