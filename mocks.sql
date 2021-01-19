-- ���������� �����������
declare
  person_rec persons%ROWTYPE;
  employee_rec employees%ROWTYPE;
begin
  person_rec.firstname:= '���������';
  person_rec.lastname:= '���������';
  person_rec.b_date:=TO_DATE('1971/05/03', 'yyyy/mm/dd');
  person_rec.sex:= '�';
  add_person(person_rec);
  employee_rec.id_person:=person_rec.id;
  employee_rec.tabel_number:=401;
  employee_rec.post:='�����������';
  add_employee(employee_rec);
  
  person_rec.firstname:= '�����';
  person_rec.lastname:= '����';
  person_rec.b_date:=TO_DATE('1980/05/21', 'yyyy/mm/dd');
  person_rec.sex:= '�';
  add_person(person_rec);
  employee_rec.id_person:=person_rec.id;
  employee_rec.tabel_number:=402;
  employee_rec.post:='���������';
  add_employee(employee_rec);
end;
/

-- ���������� ����� �������
DECLARE
  room_type_rec room_types%ROWTYPE;
BEGIN
  room_type_rec.name:='�����������';
  room_type_rec.place_count:=2;
  room_type_rec.base_price:=2500;
  add_room_type(room_type_rec);
  
  room_type_rec.name:='����';
  room_type_rec.place_count:=2;
  room_type_rec.base_price:=5000;
  add_room_type(room_type_rec);
END;
/

-- ���������� �������
DECLARE
  room_rec rooms%ROWTYPE;
BEGIN
  room_rec.room_number:=100;
  room_rec.id_type:=1;
  add_room(room_rec);

  room_rec.room_number:=101;
  add_room(room_rec);

  room_rec.room_number:=102;
  add_room(room_rec);

  room_rec.room_number:=103;
  add_room(room_rec);

  room_rec.room_number:=104;
  add_room(room_rec);

  room_rec.room_number:=200;
  room_rec.id_type:=2;
  add_room(room_rec);

  room_rec.room_number:=201;
  add_room(room_rec);
END;
/

-- ���������� �����
declare 
  room_type rooms.id_type%TYPE;
  date_from bookings.date_from%TYPE;
  date_to bookings.date_to%TYPE;
  person_rec persons%ROWTYPE;
begin
  room_type:=1;
  date_from:=TO_DATE('2020/01/01', 'yyyy/mm/dd');
  date_to:=TO_DATE('2020/01/10', 'yyyy/mm/dd');
  
  person_rec.firstname:= '������';
  person_rec.lastname:= '��������';
  person_rec.b_date:=TO_DATE('1969/10/11', 'yyyy/mm/dd');
  person_rec.sex:= '�';
  add_booking(room_type, date_from, date_to, person_rec);
end;
/
