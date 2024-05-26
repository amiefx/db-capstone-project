use littlelemondb;

select * from customer;

INSERT INTO `littlelemondb`.`Customer` (`CustomerID`, `Name`, `Contact`, `Address`) VALUES
(1, 'John Doe', '123-456-7890', '123 Elm Street'),
(2, 'Jane Smith', '234-567-8901', '456 Oak Street'),
(3, 'Alice Johnson', '345-678-9012', '789 Pine Street'),
(4, 'Bob Brown', '456-789-0123', '101 Maple Street'),
(5, 'Carol White', '567-890-1234', '202 Birch Street');


select * from employee;

INSERT INTO `littlelemondb`.`Employee` (`EmployeeID`, `Name`, `Role`, `Salary`) VALUES
(1, 'Michael Scott', 'Waiter', 75000),
(2, 'Dwight Schrute', 'Waiter', 60000),
(3, 'Jim Halpert', 'Waiter', 55000),
(4, 'Pam Beesly', 'Receptionist', 40000),
(5, 'Stanley Hudson', 'Waiter', 50000);


select * from menuitems;

INSERT INTO `littlelemondb`.`MenuItems` (`ItemID`, `Name`, `Type`, `Price`) VALUES
(1, 'Margherita Pizza', 'Main Course', '10.99'),
(2, 'Caesar Salad', 'Starter', '7.99'),
(3, 'Spaghetti Carbonara', 'Main Course', '12.99'),
(4, 'Garlic Bread', 'Starter', '4.99'),
(5, 'Tiramisu', 'Dessert', '6.99');

