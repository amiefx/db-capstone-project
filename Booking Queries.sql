use littlelemondb;

-- Task 1
-- Little Lemon wants to populate the Bookings table of their database with some records of data. Your first task is to replicate the list of records in the following table by adding them to the Little Lemon booking table. 

INSERT INTO Bookings (BookingID, BookingDate, TableNO, CustomerID, BookingSlot, EmployeeID) VALUES
(1, '2024-05-26', 1, 1, '18:00:00', 1),
(2, '2024-05-26', 2, 2, '18:30:00', 2),
(3, '2024-05-26', 3, 3, '19:00:00', 3),
(4, '2024-05-26', 4, 4, '19:30:00', 4),
(5, '2024-05-26', 5, 5, '20:00:00', 5),
(6, '2024-05-27', 1, 1, '18:00:00', 1),
(7, '2024-05-27', 2, 2, '18:30:00', 2),
(8, '2024-05-27', 3, 3, '19:00:00', 3),
(9, '2024-05-27', 4, 4, '19:30:00', 4),
(10, '2024-05-27', 5, 5, '20:00:00', 5),
(11, '2024-05-28', 1, 1, '18:00:00', 1),
(12, '2024-05-28', 2, 2, '18:30:00', 2),
(13, '2024-05-28', 3, 3, '19:00:00', 3),
(14, '2024-05-28', 4, 4, '19:30:00', 4),
(15, '2024-05-28', 5, 5, '20:00:00', 5),
(16, '2024-05-29', 1, 1, '18:00:00', 1),
(17, '2024-05-29', 2, 2, '18:30:00', 2),
(18, '2024-05-29', 3, 3, '19:00:00', 3),
(19, '2024-05-29', 4, 4, '19:30:00', 4),
(20, '2024-05-29', 5, 5, '20:00:00', 5),
(21, '2024-05-30', 1, 1, '18:00:00', 1),
(22, '2024-05-30', 2, 2, '18:30:00', 2),
(23, '2024-05-30', 3, 3, '19:00:00', 3),
(24, '2024-05-30', 4, 4, '19:30:00', 4),
(25, '2024-05-30', 5, 5, '20:00:00', 5),
(26, '2024-05-31', 1, 1, '18:00:00', 1),
(27, '2024-05-31', 2, 2, '18:30:00', 2),
(28, '2024-05-31', 3, 3, '19:00:00', 3),
(29, '2024-05-31', 4, 4, '19:30:00', 4),
(30, '2024-05-31', 5, 5, '20:00:00', 5);



-- Task 2
-- For your second task, Little Lemon need you to create a stored procedure called CheckBooking to check whether a table in the restaurant is already booked. Creating this procedure helps to minimize the effort involved in repeatedly coding the same SQL statements.
-- The procedure should have two input parameters in the form of booking date and table number. You can also create a variable in the procedure to check the status of each table.

DELIMITER //

CREATE PROCEDURE CheckBooking(IN p_BookingDate DATE, IN p_TableNO INT)
BEGIN
    DECLARE table_status INT;

    -- Check if the table is already booked on the given date
    SELECT COUNT(*) INTO table_status
    FROM Bookings
    WHERE BookingDate = p_BookingDate AND TableNO = p_TableNO;

    -- Return the result
    IF table_status > 0 THEN
        SELECT 'The table is already booked.' AS Status;
    ELSE
        SELECT 'The table is available.' AS Status;
    END IF;
END //

DELIMITER ;


call CheckBooking('2024-05-28', 1);



-- Task 3
-- For your third and final task, Little Lemon need to verify a booking, and decline any reservations for tables that are already booked under another name. 
-- Since integrity is not optional, Little Lemon need to ensure that every booking attempt includes these verification and decline steps. However, implementing these steps requires a stored procedure and a transaction. 
-- To implement these steps, you need to create a new procedure called AddValidBooking. This procedure must use a transaction statement to perform a rollback if a customer reserves a table that’s already booked under another name.  
-- Use the following guidelines to complete this task:
-- The procedure should include two input parameters in the form of booking date and table number.
-- It also requires at least one variable and should begin with a START TRANSACTION statement.
-- Your INSERT statement must add a new booking record using the input parameter's values.
-- Use an IF ELSE statement to check if a table is already booked on the given date. 
-- If the table is already booked, then rollback the transaction. If the table is available, then commit the transaction. 

CREATE PROCEDURE AddValidBooking(
    IN p_BookingDate DATE,
    IN p_TableNO INT,
    IN p_CustomerID INT,
    IN p_BookingSlot TIME,
    IN p_EmployeeID INT
)
BEGIN
    DECLARE table_status INT;

    -- Start the transaction
    START TRANSACTION;

    -- Check if the table is already booked on the given date
    SELECT COUNT(*) INTO table_status
    FROM Bookings
    WHERE BookingDate = p_BookingDate AND TableNO = p_TableNO;

    -- If the table is already booked, rollback the transaction
    IF table_status > 0 THEN
        ROLLBACK;
        SELECT 'The table is already booked.' AS Status;
    ELSE
        -- If the table is available, insert the new booking and commit the transaction
        INSERT INTO Bookings (TableNO, CustomerID, BookingSlot, EmployeeID, BookingDate)
        VALUES (p_TableNO, p_CustomerID, p_BookingSlot, p_EmployeeID, p_BookingDate);
        
        COMMIT;
        SELECT 'Booking successful.' AS Status;
    END IF;
END //

DELIMITER ;

CALL AddValidBooking('2024-01-01', 1, 1, '18:00:00', 3);