use alriyar_db;
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    City VARCHAR(50)
);
select*from  Customers;
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Order_Date DATE,
    Order_Amount DECIMAL(10,2),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

CREATE TABLE Invoices (
    Invoice_ID INT PRIMARY KEY,
    Order_ID INT,
    Invoice_Date DATE,
    Invoice_Amount DECIMAL(10,2),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    Invoice_ID INT,
    Payment_Date DATE,
    Payment_Amount DECIMAL(10,2),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoices(Invoice_ID)
);

CREATE TABLE Ledger (
    Ledger_ID INT PRIMARY KEY,
    Customer_ID INT,
    Transaction_Date DATE,
    Debit DECIMAL(10,2),
    Credit DECIMAL(10,2),
    Description VARCHAR(100),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);
INSERT INTO Customers VALUES
(1, 'Alriya', 'Kochi'),
(2, 'andrea', 'Bangalore'),
(3, 'joshna', 'Chennai'),
(4, 'deepika', 'Mangalore'),
(5, 'jenevia', 'Delhi'),
(6, 'sweedal', 'Mumbai');
select* from Customers;

INSERT INTO Orders VALUES
(101,1,"2021-04-10",50000),
(102,2,"2022-04-21",30000),
(103,4,"2025-06-22",25000),
(104,5,"2024-08-30",15000),
(105,6,"2023-01-12",20000);
select* from Orders;

INSERT INTO Invoices  VALUES
(1001,101,"2021-04-10",51000),
(1002,102,"2022-04-21",33000),
(1003,103,"2025-06-22",25400),
(1004,104,"2024-08-30",15100),
(1005,105,"2023-01-12",21000);
select* from Invoices ;


INSERT INTO Payments  VALUES
(201,1001,"2021-04-10",32011),
(202,1002,"2022-04-21",21000),
(203,1003,"2025-06-22",10000),
(204,1004,"2024-08-30",56300),
(205,1005,"2023-01-12",21000);
select* from  Payments;

INSERT INTO Ledger VALUES
(2001,1,"2022-04-10",500,10,"creditors"),
(2002,2,"2023-04-21",2000,20,"debtors"),
(2003,3,"2022-06-22",3000,30,"payment"),
(2004,4,"2025-08-30",4000,40,"cash"),
(2005,5,"2026-01-12",8000,50,"capital");
select* from  Ledger;

select
       c.Customer_ID,
       c.Customer_Name,
       c.City,
       o.Order_ID,
       o.Order_date,
       o.Order_Amount
from Customers c
INNER join Orders o
on c.Customer_ID=o.Customer_ID;

select
	  i.Invoice_ID,
      i.Order_ID,
	  i.Invoice_date,
      i.Invoice_amount,
      p.Payment_ID,
	  p.Invoice_ID,
      p.Payment_date,
      p.Payment_amount
from Invoices i
right join Payments p
on i.Invoice_ID=p.Invoice_ID;

select
       l.Ledger_ID,
       l.Customer_ID,
       l.Transaction_date,
       l.Debit,
       l.Credit,
       c.Customer_ID,
       c.Customer_Name,
       c.City
       
from Ledger l
left join Customers c
on l.Customer_ID = c.Customer_ID;


select
      c.Customer_ID,
	  c.Customer_Name,
	  c.City,
      o.Order_ID,
	  o.Order_date,
	  o.Order_Amount,
      i.Invoice_ID,
      i.Order_ID,
	  i.Invoice_date,
      p.Payment_ID,
	  p.Invoice_ID,
      p.Payment_date,
      l.Ledger_ID,
      l.Customer_ID,
	  l.Transaction_date
from Customers c
LEFT JOIN Orders o
ON c.Customer_ID=o.Customer_ID
LEFT JOIN Invoices i
ON o.Order_ID=i.Order_ID
LEFT JOIN Payments p
ON i.Invoice_ID=p.Invoice_ID
LEFT JOIN Ledger l
ON c.Customer_ID=l.Customer_ID;


