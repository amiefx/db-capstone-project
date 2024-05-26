use littlelemondb;

-- Task 1
-- In the first task, Little Lemon need you to create a virtual table called OrdersView that focuses on OrderID, Quantity and Cost columns within the Orders table for all orders with a quantity greater than 2. 
-- Here’s some guidance around completing this task: 
-- Use a CREATE VIEW statement.
-- Extract the order id, quantity and cost data from the Orders table.
-- Filter data from the orders table based on orders with a quantity greater than 2. 

CREATE VIEW OrdersView AS
select OrderID, Quantity, BillAmount
from `littlelemondb`.`order`
where
    Quantity > 2;
    
select * from ordersview;



-- Task 2
-- For your second task, Little Lemon need information from four tables on all customers with orders that cost more than $150. Extract the required information from each of the following tables by using the relevant JOIN clause: 
-- Customers table: The customer id and full name.
-- Orders table: The order id and cost.
-- Menus table: The menus name.
-- MenusItems table: course name and starter name.
-- The result set should be sorted by the lowest cost amount.

CREATE VIEW OrdersView2 AS
select c.CustomerID, c.Name, o.OrderID, o.BillAmount as TotalCost, m.MenuName, i.Name as Item, i.Type
from
    customer c
    inner join `littlelemondb`.`order` o on o.CustomerID = c.CustomerID
    join menu m on m.MenuID = o.MenuID
    join menuitems i on i.ItemID = m.ItemID
order by BillAmount asc;

select * from OrdersView2;

-- Task 3
-- For the third and final task, Little Lemon need you to find all menu items for which more than 2 orders have been placed. You can carry out this task by creating a subquery that lists the menu names from the menus table for any order quantity with more than 2.
-- Here’s some guidance around completing this task: 
-- Use the ANY operator in a subquery
-- The outer query should be used to select the menu name from the menus table.
-- The inner query should check if any item quantity in the order table is more than 2. 

CREATE VIEW OrdersView3 AS
SELECT m.MenuName
FROM `littlelemondb`.`Menu` m
WHERE
    m.MenuID = ANY (
        SELECT o.MenuID
        FROM `littlelemondb`.`order` o
        WHERE
            o.Quantity > 2
    );
    
select * from OrdersView3;