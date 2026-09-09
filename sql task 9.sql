use my_database;
create table transactions (
    transaction_id INT PRIMARY KEY,
    transaction_date DATE,
    department varchar(50),
    transaction_type varchar(40),
    amount decimal(10,2)
);

INSERT INTO transactions
(transaction_id,transaction_date,department,transaction_type,amount)
VALUES
(1,'2024-03-01',"sales","income",40000),
(2,'2025-05-02',"HR","Expenses",60000),
(3,'2024-01-05',"Sales","income",55000),
(4,'2025-11-06',"IT","income",30000),
(5,'2026-04-10',"sales","expenses",10000),
(6,'2025-09-11',"HR","income",87000),
(7,'2024-06-21',"IT","expenses",65000),
(8,'2025-12-13',"Sales","income",89000),
(9,'2026-02-23',"HR","expenses",50000),
(10,'2025-08-31',"IT","income",33000),
(11,'2024-05-18',"Sales","expenses",45000),
(12,'2026-10-03',"HR","income",66000);

SELECT * FROM transactions;

select year(transaction_date) as year,month(transaction_date) as month,sum(amount) as total_amount
from transactions
group by year(transaction_date),month(transaction_date);

select year(transaction_date)as year,month(transaction_date)as month,sum(amount) as total_amount
from transactions
group by year(transaction_date),month(transaction_date);

with monthly_summary as(
select year(transaction_date)as year,month(transaction_date)as month,sum(amount) as total_amount
from transactions
group by year(transaction_date),month(transaction_date)
)
select*from monthly_summary; 

select year(transaction_date)as year,month(transaction_date)as month,sum(amount) as total_amount
from transactions
where transaction_type="income"
group by year(transaction_date),month(transaction_date);
select*from transactions;


select year(transaction_date)as year,sum(amount) as total_income
from transactions
where transaction_type="income"
group by year(transaction_date);  

select department,sum(amount) as total_expenses
from transactions
where transaction_type="expenses"
group by department;

select year(transaction_date)as year,department,sum(amount) as total_expenses
from transactions
where transaction_type="expenses"
group by year(transaction_date),department;