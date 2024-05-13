# Hotel-management-with-pl-SQL-

HOTEL MANAGEMENT - DBMS (PL/SQL QUERIES)
#Find Hotel
declare
v_h_id hotel.hotel_id%type;
v_h_name hotel.hotel_name%type;
v_h_address hotel.hotel_address%type;
v_h_phone hotel.hotel_phone%type;
begin
v_h_id:=&v_h_id;
select hotel_id,hotel_name,hotel_address,hotel_phone
into
v_h_id,v_h_name,v_h_address,v_h_phone
from hotel
where hotel_id=v_h_id;
dbms_output.put_line(v_h_id);
dbms_output.put_line(v_h_name);
dbms_output.put_line(v_h_address);
dbms_output.put_line(v_h_phone);
end;
/
#Find Guest
declare
v_guest_id guest.guest_id%type;
v_guest_name guest.guest_name%type;
v_guest_phone guest.guest_phone%type;
v_guest_email guest.guest_email%type;
begin
v_guest_id:=&v_guest_id;
select guest_id,guest_name,guest_phone,guest_email
into
v_guest_id,v_guest_name,v_guest_phone,v_guest_email
from guest
where guest_id=v_guest_id;
dbms_output.put_line(v_guest_id);
dbms_output.put_line(v_guest_name);
dbms_output.put_line(v_guest_phone);
dbms_output.put_line(v_guest_email);
end;
/
#Find Room
declare
v_room_id room.room_id%type;
v_hotel_id room.hotel_id%type;
v_room_size room.room_size%type;
v_room_capacity room.room_capacity%type;
begin
v_room_id:=&v_room_id;
select room_id,hotel_id,room_size,room_capacity
into
v_room_id,v_hotel_id,v_room_size,v_room_capacity
from room
where room_id=v_room_id;
dbms_output.put_line(v_room_id);
dbms_output.put_line(v_hotel_id);
dbms_output.put_line(v_room_size);
dbms_output.put_line(v_room_capacity);
end;
/
#Find Room Reservation
declare
v_room_id room_reservation.room_id%type;
v_guest_id room_reservation.guest_id%type;
v_booking_id room_reservation.booking_id%type;
v_booking_invoice room_reservation.booking_invoice%type;
begin
v_booking_id:=&v_booking_id;
select room_id,guest_id,booking_id,booking_invoice
into
v_room_id,v_guest_id,v_booking_id,v_booking_invoice
from room_reservation where booking_id=v_booking_id;
dbms_output.put_line(v_room_id);
dbms_output.put_line(v_guest_id);
dbms_output.put_line(v_booking_id);
dbms_output.put_line(v_booking_invoice);
end;
/
#Find Event
declare
v_event_id event.event_id%type;
v_event_name event.event_name%type;
begin
v_event_id:=&v_event_id;
select event_id,event_name
into
v_event_id,v_event_name
from event
where event_id=v_event_id;
dbms_output.put_line(v_event_id);
dbms_output.put_line(v_event_name);
end;
/
#Find Event in hotel
declare
v_event_id event_in_hotel.event_id%type;
v_guest_id event_in_hotel.guest_id%type;
v_reserv_id event_in_hotel.reserv_id%type;
v_start_date event_in_hotel.start_date%type;
v_end_date event_in_hotel.end_date%type;
v_event_invoice event_in_hotel.event_invoice%type;
begin
v_reserv_id:=&v_reserv_id;
select event_id,guest_id,reserv_id,start_date,end_date,event_invoice
into
v_event_id,v_guest_id,v_reserv_id,v_start_date,v_end_date,v_event_invoice
from event_in_hotel
where reserv_id=v_reserv_id;
dbms_output.put_line(v_event_id);
dbms_output.put_line(v_guest_id);
dbms_output.put_line(v_reserv_id);
dbms_output.put_line(v_start_date);
dbms_output.put_line(v_end_date);
dbms_output.put_line(v_event_invoice);
end;
/
HOTEL MANAGEMENT - DBMS (create table and create sequence queries)
#table hotel
create table hotel(hotel_id number primary key,hotel_name varchar(25),hotel_address
varchar(25),hotel_phone varchar(25));
#sequence hotel_seq (for hotel_id)
create sequence hotel_seq start with 1 increment by 1 maxvalue 999999 order;
#table room
create table room(room_id number primary key,hotel_id number,room_price number,room_size
varchar(25),room_capacity number,constraint room_fk foreign key(hotel_id) references
hotel(hotel_id),constraint room_size_ck check (room_size in ('small','medium','large')));
#sequence room_seq (for room_id)
create sequence room_seq start with 1 increment by 1 maxvalue 999999 order;
#table guest
create table guest(guest_id number primary key,guest_name varchar(25),guest_phone
varchar(25),guest_email varchar(35));
#sequence guest_seq (for guest_id)
create sequence guest_seq start with 1 increment by 1 maxvalue 999999 order;
#table room_reservation
create table room_reservation(room_id number,guest_id number,booking_id
number,booking_invoice number,constraint reserv_pk primary key(room_id,guest_id),foreign
key(room_id) references room(room_id),foreign key(guest_id) references guest(guest_id));
#table event
create table event(event_id number primary key,event_name varchar(25));
#sequence event_seq (for event_id)
create sequence event_seq start with 1 increment by 1 maxvalue 999999 order;
#table event_in_hotel
create table event_in_hotel(event_id number,guest_id number,reserv_id number,start_date
date,end_date date,event_invoice number,constraint room_hotel_pk primary
key(event_id,guest_id));
HOTEL MANAGEMENT - DBMS (SQL and PL/SQL using CURSORS queries)
#Finding the hotel name,id and room id when the price of the room is greater than 15000.
select hotel.hotel_name,hotel.hotel_id,room.room_id,room.room_price from hotel,room where
room.room_price>15000;
#Finding the names of the guests who have reserved a room for the invoice of 20000.
select guest.guest_id,guest.guest_name,room_reservation.room_id,
room_reservation.booking_invoice from guest,room_reservation where
room_reservation.booking_invoice=20000;
#Finding the details from the event_in_hotel table, where the event_invoice of the guests is greater
than 9000.
declare
cursor c_event
is
select * from event_in_hotel where event_invoice>9000;
vr_event c_event%rowtype;
begin
open c_event;
loop
fetch c_event into vr_event;
exit when c_event%notfound;
dbms_output.put_line(vr_event.event_id||',
'||vr_event.guest_id||',
'||vr_event.reserv_id||',
'||vr_event.start_date||',
'||vr_event.end_date||',
'||vr_event.event_invoice);
end loop;
end;
/
#Check for the number of rooms that exist with the room size of 2.
select count(*) from room where room_capacity=2;
#Check for the room_availability with respect to booking invoice(if booking invoice is 0Rs, then that
room is empty)
update room_reservation set booking_id=null where room_id=27;
update room_reservation set booking_invoice=0 where room_id=27;
select * from room_reservation where booking_invoice=0;
