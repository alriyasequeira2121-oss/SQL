use finance_db;
CREATE TABLE monthly_finances (
    id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    month_name VARCHAR(20),
    sales DECIMAL(10,2),
    expenses DECIMAL(10,2),
    tax_rate DECIMAL(5,2)
    );
    
INSERT INTO monthly_finances
VALUES
(1, 'Rahul', 'January', 50000, 30000, 10),
(2, 'Priya', 'January', 60000, 35000, 10),
(3, 'Anu', 'January', 45000, 25000, 10),

(4, 'Rahul', 'February', 55000, 32000, 10),
(5, 'Priya', 'February', 65000, 38000, 10),
(6, 'Anu', 'February', 50000, 27000, 10),

(7, 'Rahul', 'March', 60000, 34000, 10),
(8, 'Priya', 'March', 70000, 40000, 10),
(9, 'Anu', 'March', 55000, 30000, 10);

select * from monthly_finances;

DELIMITER //
CREATE procedure CalculateTaxs(
	in p_sales decimal(10,2),
    in p_tax_rate decimal(10,2)
)

BEGIN 
     SELECT p_sales as sales,
     p_tax_rate as tax_rate,
     p_sales*p_tax_rate/100 as tax_amount;
     
end //
DELIMITER ;
call CalculateTaxs(50000,3);
call CalculateTaxs(60000,5);

create table month_end_closings(
month varchar(30),
total_sales decimal(10,2),
total_expenses decimal(10,2),
profit_lose decimal(10,2)
);


DELIMITER  //
create procedure month_end_closingss(
in p_month varchar(20))
BEGIN
insert into month_end_closings (month,total_sales,total_expenses,profit_lose)
select month_name,sum(sales),sum(expenses),sum(sales)-sum(expenses)
from monthly_finance
where month_name=p_month
group by month_name;

END //
DELIMITER ;

call month_end_closingss ('March');
call month_end_closingss('February');
select*from month_end_closings;

DELIMITER //
create procedure customersummaryss(
	in p_customer varchar(50)
)
BEGIN
	SELECT
		customer_name,
		sum(sales) as total_sales,
		sum(expenses) as total_expenses,
		sum(sales)-sum(expenses) as total_profit
	from monthly_finances
    where customer_name=p_customer
    group by customer_name;
END //
DELIMITER ;
 
 call customersummaryss("Anu");
 call customersummaryss("priya"); 
 
 create table year_end_profits(
 total_sales varchar(40),
 total_expenses varchar(50),
 total_profit varchar(20)
 );
DELIMITER //
create procedure year_end_profits()
BEGIN
	insert into year_end_profits
    (total_sales,total_expenses,total_profit)
	select SUM(sales),SUM(expenses),SUM(sales) - SUM(expenses)
FROM monthly_finances;

END //
DELIMITER ;

call year_end_profits();
select*from year_end_profits;