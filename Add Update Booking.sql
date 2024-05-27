-- Task 1
-- In this first task you need to create a new procedure called AddBooking to add a new table booking record.
-- The procedure should include four input parameters in the form of the following bookings parameters:
-- booking id, 
-- customer id, 
-- booking date,
-- and table number.

DELIMITER //

CREATE PROCEDURE AddBooking(
    IN p_BookingID INT,
    IN p_BookingDate DATE,
    IN p_TableNO INT,
    IN p_CustomerID INT,
    IN p_BookingSlot TIME,
    IN p_EmployeeID INT
)
BEGIN
    INSERT INTO Bookings (BookingID, BookingDate, TableNO, CustomerID, BookingSlot, EmployeeID )
    VALUES (p_BookingID, p_BookingDate, p_TableNO, p_CustomerID, p_BookingSlot, p_EmployeeID);

    SELECT 'Booking added successfully.' AS Status;
END //

DELIMITER ;

CALL AddBooking(31, '2024-06-02', 2, 1, '05:00:00', 1);

select * from Bookings;


-- Task 2
-- For your second task, Little Lemon need you to create a new procedure called UpdateBooking that they can use to update existing bookings in the booking table.
-- The procedure should have two input parameters in the form of booking id and booking date. You must also include an UPDATE statement inside the procedure.

DELIMITER //

CREATE PROCEDURE UpdateBooking(
    IN p_BookingID INT,
    IN p_BookingDate DATE
)
BEGIN
    UPDATE Bookings
    SET BookingDate = p_BookingDate
    WHERE BookingID = p_BookingID;

    SELECT 'Booking updated successfully.' AS Status;
END //

DELIMITER ;

CALL UpdateBooking(1, '2024-07-01');


-- Task 3
-- For the third and final task, Little Lemon need you to create a new procedure called CancelBooking that they can use to cancel or remove a booking.
-- The procedure should have one input parameter in the form of booking id. You must also write a DELETE statement inside the procedure. 

DELIMITER //

CREATE PROCEDURE CancelBooking(
    IN p_BookingID INT
)
BEGIN
    DELETE FROM Bookings
    WHERE BookingID = p_BookingID;

    SELECT 'Booking canceled successfully.' AS Status;
END //

DELIMITER ;

CALL CancelBooking(31);
