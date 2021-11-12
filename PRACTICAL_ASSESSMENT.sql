--1. create a table-valued function that returns a list of orders including order id, customer id, order status, store id and staff id for the given year range

CREATE FUNCTION test2 (
    @order_date Date, @order_date2 Date
)
RETURNS TABLE
AS
RETURN
    SELECT 
        order_id,customer_id,order_date,order_status, store_id,staff_id
    FROM
        sales.orders
    WHERE
        order_date  between @order_date and @order_date2;

select * from test2('2016','2017')





--2. create a trigger that logs all removed records of customers table
CREATE TABLE sales.customer_audits(
    change_id INT IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	street VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
	zip_code VARCHAR(255) NOT NULL,
    updated_at DATETIME NOT NULL,
    operation CHAR(3) NOT NULL,
    CHECK(operation='DEL')
);

CREATE TRIGGER sales.trg_customer_audit
ON sales.customers
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO sales.customer_audits(customer_id, first_name,last_name,phone,email,street, city,state,zip_code,updated_at, operation)
    SELECT
        customer_id, first_name, last_name,phone, email, street, city,state,zip_code, GETDATE(),'DEL'
    FROM
        deleted;
END

select * from sales.customer_audits

select * from sales.customers

Delete from sales.customers 
where customer_id=873

