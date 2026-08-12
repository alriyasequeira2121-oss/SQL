create database my_FinancialDB;
use my_FinancialDB;
create table customers(
Customer_ID INT PRIMARY KEY,
Customer_Name VARCHAR(100) NOT NULL,
Email VARCHAR(120) UNIQUE,
Phone int
);
INSERT INTO customers values(1,'alriya','xyz@gmail.com',45621225),(2,'aishu','abc@gmail.com',78965451);
SELECT*FROM customers;
create table accounts(
Account_ID INT PRIMARY KEY,
Customer_ID INT,
Account_type varchar(50) NOT NULL,
Balance decimal(12,2),
constraint accounts_bal check (balance>=0),
FOREIGN KEY (Customer_ID) references customers(Customer_ID)
);
INSERT INTO customers values(1001,1,'saving',1000.00),(1002,'fixed',2000.00);
select*from accounts;
create table transactions(
Transaction_id INT PRIMARY KEY,
Account_ID INT,
Transaction_date date,
Transaction_type VARCHAR(10),
Amount decimal(15,2),
constraint transaction_t CHECK (Transaction_type IN ('Credit','Debit')),
constraint transaction_ac check(amount>=0),
FOREIGN KEY (Account_ID) references accounts(Account_ID)
);
INSERT INTO customers values(1, '2026-08-01', 'Credit', 5000.00),(2, '2026-08-03', 'Debit', 1200.00);
SELECT*from transactions;
alter table customers
add address varchar(80);
alter table transactions
add phone int;
drop table amount;
describe customers;
describe transaction;
describe accounts;
