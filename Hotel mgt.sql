-- HOTEL MANAGEMENT DBMS PROJECT SQL AND PL/SQL CODE

-- ==========================
-- TABLE CREATION STATEMENTS
-- ==========================

CREATE TABLE hotel (
    hotel_id NUMBER PRIMARY KEY,
    hotel_name VARCHAR2(25),
    hotel_address VARCHAR2(25),
    hotel_phone VARCHAR2(25)
);

CREATE SEQUENCE hotel_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999 ORDER;

CREATE TABLE room (
    room_id NUMBER PRIMARY KEY,
    hotel_id NUMBER,
    room_price NUMBER,
    room_size VARCHAR2(25),
    room_capacity NUMBER,
    CONSTRAINT room_fk FOREIGN KEY(hotel_id) REFERENCES hotel(hotel_id),
    CONSTRAINT room_size_ck CHECK (room_size IN ('small','medium','large'))
);

CREATE SEQUENCE room_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999 ORDER;

CREATE TABLE guest (
    guest_id NUMBER PRIMARY KEY,
    guest_name VARCHAR2(25),
    guest_phone VARCHAR2(25),
    guest_email VARCHAR2(35)
);

CREATE SEQUENCE guest_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999 ORDER;

CREATE TABLE room_reservation (
    room_id NUMBER,
    guest_id NUMBER,
    booking_id NUMBER,
    booking_invoice NUMBER,
    CONSTRAINT reserv_pk PRIMARY KEY(room_id, guest_id),
    FOREIGN KEY(room_id) REFERENCES room(room_id),
    FOREIGN KEY(guest_id) REFERENCES guest(guest_id)
);

CREATE TABLE event (
    event_id NUMBER PRIMARY KEY,
    event_name VARCHAR2(25)
);

CREATE SEQUENCE event_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999 ORDER;

CREATE TABLE event_in_hotel (
    event_id NUMBER,
    guest_id NUMBER,
    reserv_id NUMBER,
    start_date DATE,
    end_date DATE,
    event_invoice NUMBER,
    CONSTRAINT room_hotel_pk PRIMARY KEY(event_id, guest_id)
);

-- ==========================
-- PL/SQL BLOCKS FOR QUERIES
-- ==========================

-- 1. Find Hotel
DECLARE
    v_h_id hotel.hotel_id%TYPE;
    v_h_name hotel.hotel_name%TYPE;
    v_h_address hotel.hotel_address%TYPE;
    v_h_phone hotel.hotel_phone%TYPE;
BEGIN
    v_h_id := &v_h_id;
    SELECT hotel_id, hotel_name, hotel_address, hotel_phone
    INTO v_h_id, v_h_name, v_h_address, v_h_phone
    FROM hotel
    WHERE hotel_id = v_h_id;
    dbms_output.put_line(v_h_id);
    dbms_output.put_line(v_h_name);
    dbms_output.put_line(v_h_address);
    dbms_output.put_line(v_h_phone);
END;
/

-- 2. Find Guest
DECLARE
    v_guest_id guest.guest_id%TYPE;
    v_guest_name guest.guest_name%TYPE;
    v_guest_phone guest.guest_phone%TYPE;
    v_guest_email guest.guest_email%TYPE;
BEGIN
    v_guest_id := &v_guest_id;
    SELECT guest_id, guest_name, guest_phone, guest_email
    INTO v_guest_id, v_guest_name, v_guest_phone, v_guest_email
    FROM guest
    WHERE guest_id = v_guest_id;
    dbms_output.put_line(v_guest_id);
    dbms_output.put_line(v_guest_name);
    dbms_output.put_line(v_guest_phone);
    dbms_output.put_line(v_guest_email);
END;
/

-- 3. Find Room
DECLARE
    v_room_id room.room_id%TYPE;
    v_hotel_id room.hotel_id%TYPE;
    v_room_size room.room_size%TYPE;
    v_room_capacity room.room_capacity%TYPE;
BEGIN
    v_room_id := &v_room_id;
    SELECT room_id, hotel_id, room_size, room_capacity
    INTO v_room_id, v_hotel_id, v_room_size, v_room_capacity
    FROM room
    WHERE room_id = v_room_id;
    dbms_output.put_line(v_room_id);
    dbms_output.put_line(v_hotel_id);
    dbms_output.put_line(v_room_size);
    dbms_output.put_line(v_room_capacity);
END;
/

-- 4. Find Room Reservation
DECLARE
    v_room_id room_reservation.room_id%TYPE;
    v_guest_id room_reservation.guest_id%TYPE;
    v_booking_id room_reservation.booking_id%TYPE;
    v_booking_invoice room_reservation.booking_invoice%TYPE;
BEGIN
    v_booking_id := &v_booking_id;
    SELECT room_id, guest_id, booking_id, booking_invoice
    INTO v_room_id, v_guest_id, v_booking_id, v_booking_invoice
    FROM room_reservation
    WHERE booking_id = v_booking_id;
    dbms_output.put_line(v_room_id);
    dbms_output.put_line(v_guest_id);
    dbms_output.put_line(v_booking_id);
    dbms_output.put_line(v_booking_invoice);
END;
/

-- 5. Find Event
DECLARE
    v_event_id event.event_id%TYPE;
    v_event_name event.event_name%TYPE;
BEGIN
    v_event_id := &v_event_id;
    SELECT event_id, event_name
    INTO v_event_id, v_event_name
    FROM event
    WHERE event_id = v_event_id;
    dbms_output.put_line(v_event_id);
    dbms_output.put_line(v_event_name);
END;
/

-- 6. Find Event in Hotel
DECLARE
    v_event_id event_in_hotel.event_id%TYPE;
    v_guest_id event_in_hotel.guest_id%TYPE;
    v_reserv_id event_in_hotel.reserv_id%TYPE;
    v_start_date event_in_hotel.start_date%TYPE;
    v_end_date event_in_hotel.end_date%TYPE;
    v_event_invoice event_in_hotel.event_invoice%TYPE;
BEGIN
    v_reserv_id := &v_reserv_id;
    SELECT event_id, guest_id, reserv_id, start_date, end_date, event_invoice
    INTO v_event_id, v_guest_id, v_reserv_id, v_start_date, v_end_date, v_event_invoice
    FROM event_in_hotel
    WHERE reserv_id = v_reserv_id;
    dbms_output.put_line(v_event_id);
    dbms_output.put_line(v_guest_id);
    dbms_output.put_line(v_reserv_id);
    dbms_output.put_line(v_start_date);
    dbms_output.put_line(v_end_date);
    dbms_output.put_line(v_event_invoice);
END;
/

-- ==========================
-- SQL QUERIES
-- ==========================

-- 7. Hotel name, id, and room id where room price > 15000
SELECT h.hotel_name, h.hotel_id, r.room_id
FROM hotel h
JOIN room r ON h.hotel_id = r.hotel_id
WHERE r.room_price > 15000;

-- 8. Guest names who have reserved a room for invoice of 20000
SELECT g.guest_name
FROM guest g
JOIN room_reservation rr ON g.guest_id = rr.guest_id
WHERE rr.booking_invoice = 20000;

-- 9. (PL/SQL Cursor) Details from event_in_hotel where event_invoice > 9000
DECLARE
    CURSOR event_cursor IS
        SELECT * FROM event_in_hotel WHERE event_invoice > 9000;
    event_row event_in_hotel%ROWTYPE;
BEGIN
    OPEN event_cursor;
    LOOP
        FETCH event_cursor INTO event_row;
        EXIT WHEN event_cursor%NOTFOUND;
        -- process each row as needed
    END LOOP;
    CLOSE event_cursor;
END;
/

-- 10. Number of rooms with room size of 2
SELECT COUNT(*) FROM room WHERE room_size = '2';

-- 11. Room availability: booking_invoice = 0Rs (room is empty)
SELECT r.room_id
FROM room r
LEFT JOIN room_reservation rr ON r.room_id = rr.room_id
WHERE rr.booking_invoice = 0 OR rr.booking_invoice IS NULL;
