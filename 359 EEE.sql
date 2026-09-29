CREATE DATABASE BusinessFinanceDB;

USE BusinessFinanceDB;

CREATE TABLE clients (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    client_name VARCHAR(100) NOT NULL,
    email_address VARCHAR(120) UNIQUE,
    contact_number VARCHAR(20),
    location VARCHAR(60),
    registered_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE bank_accounts (
    bank_account_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT NOT NULL,
    account_code VARCHAR(30) NOT NULL UNIQUE,
    account_category ENUM('Savings', 'Current') NOT NULL,
    initial_balance DECIMAL(14,2) DEFAULT 0.00,
    account_state ENUM('Active', 'Closed') DEFAULT 'Active',
    FOREIGN KEY (client_id)
        REFERENCES clients(client_id)
);

CREATE TABLE business_orders (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_value DECIMAL(14,2) NOT NULL,
    transaction_status ENUM(
        'Pending',
        'Completed',
        'Cancelled'
    ) DEFAULT 'Completed',
    FOREIGN KEY (client_id)
        REFERENCES clients(client_id),
    CHECK (transaction_value >= 0)
);

CREATE TABLE billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_id INT NOT NULL UNIQUE,
    bill_date DATE NOT NULL,
    payment_due DATE NOT NULL,
    bill_amount DECIMAL(14,2) NOT NULL,
    FOREIGN KEY (transaction_id)
        REFERENCES business_orders(transaction_id),
    CHECK (bill_amount >= 0),
    CHECK (payment_due >= bill_date)
);

CREATE TABLE collections (
    collection_id INT PRIMARY KEY AUTO_INCREMENT,
    bill_id INT NOT NULL,
    collection_date DATE NOT NULL,
    collected_amount DECIMAL(14,2) NOT NULL,
    collection_method ENUM(
        'Cash',
        'UPI',
        'Card',
        'Bank Transfer'
    ) NOT NULL,
    FOREIGN KEY (bill_id)
        REFERENCES billing(bill_id),
    CHECK (collected_amount > 0)
);

CREATE TABLE business_expenses (
    expense_id INT PRIMARY KEY AUTO_INCREMENT,
    expense_date DATE NOT NULL,
    expense_category VARCHAR(60) NOT NULL,
    expense_description VARCHAR(200),
    expense_amount DECIMAL(14,2) NOT NULL,
    CHECK (expense_amount > 0)
);
CREATE TABLE financial_ledger (
    entry_id INT PRIMARY KEY AUTO_INCREMENT,
    bank_account_id INT NOT NULL,
    entry_date DATE NOT NULL,
    entry_type ENUM('Debit', 'Credit') NOT NULL,
    entry_amount DECIMAL(14,2) NOT NULL,
    entry_description VARCHAR(200),
    FOREIGN KEY (bank_account_id)
        REFERENCES bank_accounts(bank_account_id),
    CHECK (entry_amount > 0)
);


INSERT INTO clients
(client_id, client_name, email_address, contact_number, location)
VALUES
(1, 'Aarav', 'aarav@finance.com', '9812304501', 'Chennai'),
(2, 'Meera', 'meera@finance.com', '9823405602', 'Kochi'),
(3, 'Rohan', 'rohan@finance.com', '9834506703', 'Pune'),
(4, 'Diya', 'diya@finance.com', '9845607804', 'Hyderabad'),
(5, 'Kabir', 'kabir@finance.com', '9856708905', 'Coimbatore');
INSERT INTO bank_accounts
(bank_account_id, client_id, account_code,
 account_category, initial_balance)
VALUES
(1, 1, 'BNK2001', 'Current', 55000),
(2, 2, 'BNK2002', 'Savings', 48000),
(3, 3, 'BNK2003', 'Current', 72000),
(4, 4, 'BNK2004', 'Savings', 36000),
(5, 5, 'BNK2005', 'Current', 61000);
INSERT INTO business_orders
(transaction_id, client_id, transaction_date,
 transaction_value, transaction_status)
VALUES
(201, 1, '2026-01-08', 47000, 'Completed'),
(202, 2, '2026-01-19', 58000, 'Completed'),
(203, 1, '2026-02-14', 39000, 'Completed'),
(204, 3, '2026-03-09', 82000, 'Completed'),
(205, 4, '2026-04-16', 44000, 'Completed'),
(206, 5, '2026-05-21', 63000, 'Completed');
INSERT INTO billing
(bill_id, transaction_id, bill_date,
 payment_due, bill_amount)
VALUES
(2101, 201, '2026-01-08', '2026-01-23', 47000),
(2102, 202, '2026-01-19', '2026-02-03', 58000),
(2103, 203, '2026-02-14', '2026-02-28', 39000),
(2104, 204, '2026-03-09', '2026-03-24', 82000),
(2105, 205, '2026-04-16', '2026-05-01', 44000),
(2106, 206, '2026-05-21', '2026-06-05', 63000);
INSERT INTO collections
(collection_id, bill_id, collection_date,
 collected_amount, collection_method)
VALUES
(3101, 2101, '2026-01-20', 25000, 'UPI'),
(3102, 2102, '2026-01-30', 58000, 'Bank Transfer'),
(3103, 2103, '2026-02-25', 18000, 'Card'),
(3104, 2104, '2026-03-22', 82000, 'Bank Transfer'),
(3105, 2105, '2026-04-28', 20000, 'Cash'),
(3106, 2106, '2026-05-31', 63000, 'UPI');
INSERT INTO business_expenses
(expense_id, expense_date, expense_category,
 expense_description, expense_amount)
VALUES
(4101, '2026-01-11', 'Rent', 'Branch office rent', 18000),
(4102, '2026-02-08', 'Salary', 'Staff payroll', 28000),
(4103, '2026-03-13', 'Utilities', 'Monthly utility bill', 7500),
(4104, '2026-04-10', 'Advertising', 'Online advertising', 13500),
(4105, '2026-05-17', 'Travel', 'Client meeting travel', 8500),
(4106, '2026-06-12', 'Supplies', 'Stationery and supplies', 6200);
INSERT INTO financial_ledger
(entry_id, bank_account_id, entry_date,
 entry_type, entry_amount, entry_description)
VALUES
(5101, 1, '2026-01-08', 'Credit', 47000, 'Business collection'),
(5102, 2, '2026-01-19', 'Credit', 58000, 'Business collection'),
(5103, 3, '2026-03-09', 'Credit', 82000, 'Business collection'),
(5104, 4, '2026-04-16', 'Credit', 44000, 'Business collection'),
(5105, 5, '2026-05-21', 'Credit', 63000, 'Business collection'),
(5106, 1, '2026-02-08', 'Debit', 28000, 'Salary payment');



SELECT * FROM clients;
SELECT * FROM bank_accounts;
SELECT * FROM business_orders;

SELECT * FROM billing;

SELECT * FROM collections;

SELECT * FROM business_expenses;

SELECT * FROM financial_ledger;

SELECT *
FROM business_orders
WHERE transaction_status = 'Completed';

SELECT *
FROM business_orders
WHERE transaction_value > 50000;
SELECT *
FROM business_expenses
ORDER BY expense_amount DESC;

SELECT SUM(transaction_value) AS total_sales
FROM business_orders
WHERE transaction_status = 'Completed';
SELECT SUM(expense_amount) AS total_expenses
FROM business_expenses;

SELECT
    expense_category,
    COUNT(*) AS expense_count,
    SUM(expense_amount) AS total_expenses,
    AVG(expense_amount) AS average_expenses
FROM business_expenses
GROUP BY expense_category;

SELECT
    expense_id,
    expense_category,
    expense_amount,
    CASE
        WHEN expense_amount >= 20000 THEN 'High'
        WHEN expense_amount >= 10000 THEN 'Medium'
        ELSE 'Low'
    END AS expense_level
FROM business_expenses;




SELECT
    c.client_id,
    c.client_name,
    b.transaction_id,
    b.transaction_value
FROM clients c
INNER JOIN business_orders b
ON c.client_id = b.client_id;

SELECT
    c.client_id,
    c.client_name,
    b.transaction_id,
    b.transaction_value
FROM clients c
LEFT JOIN business_orders b
ON c.client_id = b.client_id;
SELECT
    c.client_name,
    b.transaction_id,
    b.transaction_value
FROM clients c
RIGHT JOIN business_orders b
ON c.client_id = b.client_id;

SELECT
    c.client_id,
    c.client_name,
    COALESCE(SUM(b.transaction_value), 0) AS total_sales
FROM clients c
LEFT JOIN business_orders b
ON c.client_id = b.client_id
GROUP BY c.client_id, c.client_name;

SELECT
    c.client_name,
    b.transaction_id,
    bl.bill_id,
    bl.bill_amount,
    co.collection_id,
    co.collected_amount
FROM clients c
INNER JOIN business_orders b
    ON c.client_id = b.client_id
INNER JOIN billing bl
    ON b.transaction_id = bl.transaction_id
LEFT JOIN collections co
    ON bl.bill_id = co.bill_id;


CREATE OR REPLACE VIEW billing_balance_view AS
SELECT
    c.client_id,
    c.client_name,
    bl.bill_id,
    bl.bill_date,
    bl.payment_due,
    bl.bill_amount,
    COALESCE(SUM(co.collected_amount), 0) AS paid_amount,
    bl.bill_amount -
    COALESCE(SUM(co.collected_amount), 0) AS balance
FROM clients c
INNER JOIN business_orders b
    ON c.client_id = b.client_id
INNER JOIN billing bl
    ON b.transaction_id = bl.transaction_id
LEFT JOIN collections co
    ON bl.bill_id = co.bill_id
GROUP BY
    c.client_id,
    c.client_name,
    bl.bill_id,
    bl.bill_date,
    bl.payment_due,
    bl.bill_amount;

SELECT *
FROM billing_balance_view;

SELECT *
FROM billing_balance_view
WHERE balance > 0;

SELECT *
FROM billing_balance_view
WHERE balance > 0
AND payment_due < CURRENT_DATE();


SELECT *
FROM business_orders
WHERE transaction_value > (
    SELECT AVG(transaction_value)
    FROM business_orders
);

SELECT *
FROM business_orders
WHERE transaction_value = (
    SELECT MAX(transaction_value)
    FROM business_orders
);

SELECT *
FROM clients c
WHERE EXISTS (
    SELECT 1
    FROM business_orders b
    WHERE b.client_id = c.client_id
);

SELECT
    transaction_id,
    transaction_value,
    RANK() OVER (
        ORDER BY transaction_value DESC
    ) AS transaction_rank
FROM business_orders;

SELECT
    transaction_id,
    transaction_value,
    DENSE_RANK() OVER (
        ORDER BY transaction_value DESC
    ) AS transaction_rank
FROM business_orders;

SELECT
    transaction_id,
    transaction_date,
    transaction_value,
    LAG(transaction_value) OVER (
        ORDER BY transaction_date, transaction_id
    ) AS previous_transaction_value
FROM business_orders;

SELECT
    transaction_id,
    transaction_date,
    transaction_value,
    LEAD(transaction_value) OVER (
        ORDER BY transaction_date, transaction_id
    ) AS next_transaction_value
FROM business_orders;

SELECT
    transaction_id,
    transaction_date,
    transaction_value,
    SUM(transaction_value) OVER (
        ORDER BY transaction_date, transaction_id
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS running_total
FROM business_orders;

DELIMITER //

CREATE PROCEDURE get_client_summary(
    IN p_client_id INT
)
BEGIN

    SELECT
        c.client_id,
        c.client_name,
        COALESCE(SUM(b.transaction_value), 0) AS total_sales
    FROM clients c
    LEFT JOIN business_orders b
        ON c.client_id = b.client_id
    WHERE c.client_id = p_client_id
    GROUP BY c.client_id, c.client_name;

END //

DELIMITER ;

CALL get_client_summary(1);

DELIMITER //

CREATE PROCEDURE get_monthly_financial_report(
    IN p_year INT,
    IN p_month INT
)
BEGIN

    SELECT
        p_year AS report_year,
        p_month AS report_month,

        COALESCE((
            SELECT SUM(transaction_value)
            FROM business_orders
            WHERE YEAR(transaction_date) = p_year
              AND MONTH(transaction_date) = p_month
              AND transaction_status = 'Completed'
        ), 0) AS total_sales,

        COALESCE((
            SELECT SUM(expense_amount)
            FROM business_expenses
            WHERE YEAR(expense_date) = p_year
              AND MONTH(expense_date) = p_month
        ), 0) AS total_expenses,

        COALESCE((
            SELECT SUM(transaction_value)
            FROM business_orders
            WHERE YEAR(transaction_date) = p_year
              AND MONTH(transaction_date) = p_month
              AND transaction_status = 'Completed'
        ), 0)
        -
        COALESCE((
            SELECT SUM(expense_amount)
            FROM business_expenses
            WHERE YEAR(expense_date) = p_year
              AND MONTH(expense_date) = p_month
        ), 0) AS operating_surplus;

END //

DELIMITER ;

CALL get_monthly_financial_report(2026, 1);


CREATE TABLE finance_audit_log (
    audit_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    source_table VARCHAR(64) NOT NULL,
    record_id BIGINT NOT NULL,
    action_name VARCHAR(10) NOT NULL,
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action_details VARCHAR(500)
);

DELIMITER //

CREATE TRIGGER collections_after_insert
AFTER INSERT ON collections
FOR EACH ROW
BEGIN

    INSERT INTO finance_audit_log
    (
        source_table,
        record_id,
        action_name,
        action_details
    )
    VALUES
    (
        'collections',
        NEW.collection_id,
        'INSERT',
        CONCAT(
            'Bill=', NEW.bill_id,
            ', amount=', NEW.collected_amount
        )
    );

END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER collections_after_update
AFTER UPDATE ON collections
FOR EACH ROW
BEGIN

    INSERT INTO finance_audit_log
    (
        source_table,
        record_id,
        action_name,
        action_details
    )
    VALUES
    (
        'collections',
        NEW.collection_id,
        'UPDATE',
        CONCAT(
            'Old amount=', OLD.collected_amount,
            ', new amount=', NEW.collected_amount
        )
    );

END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER collections_after_delete
AFTER DELETE ON collections
FOR EACH ROW
BEGIN

    INSERT INTO finance_audit_log
    (
        source_table,
        record_id,
        action_name,
        action_details
    )
    VALUES
    (
        'collections',
        OLD.collection_id,
        'DELETE',
        CONCAT(
            'Deleted amount=', OLD.collected_amount
        )
    );

END //

DELIMITER ;


INSERT INTO collections
(
    bill_id,
    collection_date,
    collected_amount,
    collection_method
)
VALUES
(
    2101,
    '2026-09-15',
    1200,
    'UPI'
);

SELECT *
FROM finance_audit_log
ORDER BY audit_id DESC;
CREATE USER IF NOT EXISTS
'accounts_viewer'@'localhost'
IDENTIFIED BY 'FinanceView@2026!';

GRANT SELECT
ON BusinessFinanceDB.*
TO 'accounts_viewer'@'localhost';

CREATE USER IF NOT EXISTS
'accounts_operator'@'localhost'
IDENTIFIED BY 'FinanceOps@2026!';

GRANT SELECT, INSERT, UPDATE
ON BusinessFinanceDB.collections
TO 'accounts_operator'@'localhost';

SELECT
    c.client_id,
    c.client_name,
    COALESCE(SUM(b.transaction_value), 0) AS total_sales
FROM clients c
LEFT JOIN business_orders b
    ON c.client_id = b.client_id
GROUP BY c.client_id, c.client_name
ORDER BY total_sales DESC;

SELECT
    expense_category,
    COUNT(*) AS number_of_expenses,
    SUM(expense_amount) AS total_expenses,
    AVG(expense_amount) AS average_expenses
FROM business_expenses
GROUP BY expense_category
ORDER BY total_expenses DESC;

SELECT
    collection_method,
    COUNT(*) AS collection_count,
    SUM(collected_amount) AS total_collected
FROM collections
GROUP BY collection_method
ORDER BY total_collected DESC;

SELECT COUNT(*) AS client_count
FROM clients;

SELECT COUNT(*) AS bank_account_count
FROM bank_accounts;

SELECT COUNT(*) AS order_count
FROM business_orders;

SELECT COUNT(*) AS bill_count
FROM billing;

SELECT COUNT(*) AS collection_count
FROM collections;

SELECT COUNT(*) AS expense_count
FROM business_expenses;

SELECT COUNT(*) AS ledger_entry_count
FROM financial_ledger;