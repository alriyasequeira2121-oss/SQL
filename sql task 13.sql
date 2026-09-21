create database transactions;
use transactions;
CREATE TABLE customeres (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100)
);
CREATE TABLE transactions (
    transactions_id INT PRIMARY KEY,
    customer_id int,
    amount decimal(10,2),
    transactiondate date,
    foreign key(customer_id) references customeres(customer_id)
);
CREATE TABLE salaries (
    empployee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    salary decimal(10,2)
);
#query for creating users
create user "manager"@"localhost" identified by "Manager@987";
create user "accountant"@"localhost" identified by "Accountant@987";
create user "clerk"@"localhost" identified by "Clerk@987";


#grant
grant select on transactions.*
to "manager"@"localhost";

grant select,insert, update
on transactions.transactions
to "accountant"@"localhost";

grant select
on transactions.transactions
to "accountant"@"localhost";

grant select
on transactions.customeres
to "clerk"@"localhost";

grant select,insert, update
on transactions.transactions
to "clerk"@"localhost";

grant select
on transactions.customeres
to "accountant"@"localhost";

grant delete
on transactions.transactions
to "accountant"@"localhost";

revoke delete
on transactions.transactions
from "accountant"@"localhost";

show grants for "manager"@"localhost";
show grants for "accountant"@"localhost";
show grants for "clerk"@"localhost";



