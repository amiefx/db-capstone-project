use littlelemondb;

-- Task 1
-- In this first task, Little Lemon need you to create a procedure that displays the maximum ordered quantity in the Orders table. 
-- Creating this procedure will allow Little Lemon to reuse the logic implemented in the procedure easily without retyping the same code over again and again to check the maximum quantity. 

DELIMITER //
CREATE procedure getMaxQuantity()
begin
select max(quantity) from `littlelemondb`.`order`;
end //
DELIMITER ;

call getMaxQuantity();

-- Task 2
-- In the second task, Little Lemon need you to help them to create a prepared statement called GetOrderDetail. This prepared statement will help to reduce the parsing time of queries. It will also help to secure the database from SQL injections.
-- The prepared statement should accept one input argument, the CustomerID value, from a variable. 
-- The statement should return the order id, the quantity and the order cost from the Orders table. 

-- Step 1: Prepare the statement
prepare GetOrderDetail
from '
select OrderID, Quantity, BillAmount as OrderCost
from `littlelemondb`.`order`
where CustomerID = ?';

-- Step 2: Set the variable
set @id = 5;

-- Step 3: Execute the prepared statement
execute GetOrderDetail using @id;



-- Task 3
-- Your third and final task is to create a stored procedure called CancelOrder. Little Lemon want to use this stored procedure to delete an order record based on the user input of the order id.
-- Creating this procedure will allow Little Lemon to cancel any order by specifying the order id value in the procedure parameter without typing the entire SQL delete statement.  

DELIMITER //
CREATE procedure CancelOrder(IN order_id INT)
begin
delete from `littlelemondb`.`order` where OrderID = order_id;
end //
DELIMITER ;

call CancelOrder(10);

select * from `littlelemondb`.`order`
where OrderID = 10;