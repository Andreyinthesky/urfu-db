-- create schema
CREATE TABLE persons
( id NUMBER(10) NOT NULL,
  passport NUMBER(10),
  firstname VARCHAR2(255) NOT NULL,
  lastname VARCHAR2(255) NOT NULL,
  patronymic VARCHAR2(255),
  b_date DATE,
  sex VARCHAR2(1),
  CONSTRAINT persons_pk PRIMARY KEY (id) 
);

CREATE TABLE customers
( id NUMBER(10) NOT NULL,
  id_person NUMBER(10),
  CONSTRAINT customers_pk PRIMARY KEY (id),
  CONSTRAINT fk_customers_persons FOREIGN KEY (id_person) REFERENCES persons(id)
);

CREATE TABLE employees
( id NUMBER(10) NOT NULL,
  id_person NUMBER(10),
  tabel_number NUMBER(25),
  post VARCHAR2(255),
  CONSTRAINT employees_pk PRIMARY KEY (id),
  CONSTRAINT fk_employees_persons FOREIGN KEY (id_person) REFERENCES persons(id)
);

CREATE TABLE room_types
( id NUMBER(10) NOT NULL,
  name VARCHAR2(255),
  place_count NUMBER(5),
  base_price NUMBER(20),
  CONSTRAINT room_types_pk PRIMARY KEY (id)
);

CREATE TABLE rooms
( id NUMBER(10) NOT NULL,
  id_type NUMBER(10) NOT NULL,
  room_number NUMBER(10) NOT NULL,
  CONSTRAINT rooms_pk PRIMARY KEY (id),
  CONSTRAINT rooms_unique UNIQUE (room_number),
  CONSTRAINT fk_rooms_room_types FOREIGN KEY (id_type) REFERENCES room_types(id)
);

CREATE TABLE bookings
( id NUMBER(10) NOT NULL,
  id_customer NUMBER(10) NOT NULL,
  id_room NUMBER(10) NOT NULL,
  date_from DATE,
  date_to DATE,
  total_price NUMBER(20),
  CONSTRAINT bookings_pk PRIMARY KEY (id),
  CONSTRAINT fk_bookings_customers FOREIGN KEY (id_customer) REFERENCES customers(id),
  CONSTRAINT fk_bookings_rooms FOREIGN KEY (id_room) REFERENCES rooms(id)
);