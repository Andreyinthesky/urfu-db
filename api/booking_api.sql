-- Booking API
CREATE SEQUENCE booking_index
  MINVALUE 1
  START WITH 1
  INCREMENT BY 1
  CACHE 20;

CREATE OR REPLACE PROCEDURE booking_autoincrement(booking_rec IN OUT bookings%ROWTYPE) IS
  BEGIN
  SELECT booking_index.nextval
    INTO booking_rec.id
    FROM DUAL;
  END;
/

CREATE OR REPLACE PROCEDURE add_booking(room_type IN OUT rooms.id_type%TYPE,
  date_from IN OUT bookings.date_from%TYPE,
  date_to IN OUT bookings.date_to%TYPE,
  person_rec IN OUT persons%ROWTYPE) IS
  
  booking_rec bookings%ROWTYPE;
  customer_rec customers%ROWTYPE;
  
  BEGIN
  -- поиск свободного номера
  select id into booking_rec.id_room from (
    select id from rooms
    MINUS
    select id_room from bookings LEFT JOIN rooms on bookings.id_room = rooms.id
    where rooms.id_type = room_type and not (
      date_from > bookings.date_to and date_to > bookings.date_to or
      date_from < bookings.date_from and date_to < bookings.date_from)
    )
  where ROWNUM <= 1;
  
  -- подсчет цены за все дни
  select abs(date_to - date_from) * room_types.base_price as "t_price" into booking_rec.total_price from rooms
    LEFT JOIN room_types on rooms.id_type = room_types.id
  where rooms.id = booking_rec.id_room;
  
  -- добавление customer'а
  add_person(person_rec);
  customer_autoincrement(customer_rec);
  customer_rec.id_person:=person_rec.id;
  INSERT INTO customers VALUES customer_rec;
  
  -- добавление брони
  booking_autoincrement(booking_rec);
  booking_rec.date_from:=date_from;
  booking_rec.date_to:=date_to;
  booking_rec.id_customer:=customer_rec.id;
  INSERT INTO bookings VALUES booking_rec;
  
  END;
/

CREATE OR REPLACE PROCEDURE remove_booking(booking_id NUMBER) IS
  BEGIN
    DELETE FROM bookings
    where id = booking_id;
  END;
/
