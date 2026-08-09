CREATE DATABASE AlriyaDB;
USE AlriyaDB;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15)
);
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    AccountName VARCHAR(100),
    account_type VARCHAR(50),
    balance DECIMAL(10,2)
);
CREATE TABLE Ledgers (
    ledger_id INT PRIMARY KEY,
    account_id INT,
    ledger_date DATE,
    description VARCHAR(100),
    debit DECIMAL(10,2),
    credit DECIMAL(10,2),
    LedgerName VARCHAR(100)
);
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_date DATE,
    transaction_type VARCHAR(50),
    amount DECIMAL(10,2)
);
CREATE TABLE Invoices (
    invoice_id INT PRIMARY KEY,
    customer_id INT,
    issue_date DATE,
    due_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(30)
);
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    invoice_id INT,
    payment_date DATE,
    PaymentMethod VARCHAR(50),
    amount DECIMAL(10,2),
    payment_method VARCHAR(30)
);