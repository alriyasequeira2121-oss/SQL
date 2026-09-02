use alriya_db;
CREATE TABLE customeres (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);
INSERT INTO customeres (customer_id, customer_name, email, city)
VALUES
(101, 'Alriya', 'alriys@gmail.com', 'Mysore'),
(102, 'riya', 'riya@gmail.com', 'Chennai'),
(103, 'Aishwarya', 'aishwarya@gmail.com', 'Bangalore'),
(104, 'Prananya', 'prananya@gmail.com', 'Mangalore'),
(105, 'Shaina', 'shaina@gmail.com', 'Kochi');

SELECT * FROM customeres;

CREATE TABLE transactionss (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    transaction_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customeres(customer_id)
);

INSERT INTO transactionss 
(transaction_id, customer_id, amount, transaction_date)
VALUES
(1, 101, 2500, '2026-04-10'),
(2, 102, 6000, '2026-05-12'),
(3, 101, 5500, '2026-08-10'),
(4, 103, 1400, '2026-07-21'),
(5, 104, 8000, '2026-06-07'),
(6, 102, 3200, '2026-05-10'),
(7, 103, 9200, '2026-08-30'),
(8, 104, 4000, '2026-08-20'),
(9, 105, 3500, '2026-04-21'),
(10, 105, 4500, '2026-05-14'),
(11, 101, 1200, '2026-06-25'),
(12, 102, 5000, '2026-08-02');

SELECT * FROM transactionss;


CREATE TABLE invoicess (
    invoice_id INT PRIMARY KEY,
    customer_id INT,
    invoice_amount DECIMAL(10,2),
    invoice_date DATE,
    due_date DATE,
    payment_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customeres(customer_id)
);

INSERT INTO invoicess
(invoice_id, customer_id, invoice_amount, invoice_date, due_date, payment_status)
VALUES
(501, 101, 2500, '2026-04-10', '2026-08-10', 'Paid'),
(502, 102, 6000, '2026-05-12', '2026-08-15', 'Unpaid'),
(503, 103, 1400, '2026-07-21', '2026-08-20', 'Unpaid'),
(504, 104, 4000, '2026-08-20', '2026-08-25', 'Unpaid'),
(505, 105, 3500, '2026-04-21', '2026-08-28', 'Paid');

SELECT * FROM invoicess;

select customer_name from customeres where customer_id IN(
select customer_id from invoicess where payment_status="unpaid");

select customer_name from customeres where customer_id IN(
select customer_id from transactionss where amount>4500);

select customer_name from customeres where customer_id IN(
select customer_id from transactionss where amount =(
select max(amount) from transactionss));

select customer_name from transactionss where amount>(
select avg(amount) from transactionss);

select customer_name from customeres 
where city='Mangalore' and customer_id IN(
select customer_id from transactionss);

SELECT c.customer_id, c.customer_name
FROM Customeres c
WHERE NOT EXISTS (
    SELECT 1 
    FROM invoicess i
    WHERE c.customer_id = i.customer_id 
    AND i.payment_status ='Paid'
);

SELECT c.customer_id, c.customer_name
FROM Customeres c
WHERE NOT EXISTS (
    SELECT 1 
    FROM transactionss t
    WHERE c.customer_id = t.customer_id 
    AND t.amount>4500
);

SELECT t1.transaction_id, t1.customer_id, t1.amount
FROM transactionss t1
WHERE t1.amount > (
    SELECT AVG(t2.amount)
    FROM transactionss t2
    WHERE t2.customer_id = t1.customer_id
);

SELECT t1.transaction_id, t1.customer_id, t1.amount
FROM transactionss t1
WHERE t1.amount > (
    SELECT AVG(t2.amount)
    FROM transactionss t2
    WHERE t2.customer_id = t1.customer_id
);

SELECT c.customer_id, c.customer_name
FROM Customeres c
WHERE NOT EXISTS (
    SELECT 1 
    FROM transactionss t
    WHERE c.customer_id = t.customer_id 
    AND c.city='Mangalore'
);

