create database AUDIT;
use AUDIT;
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_name VARCHAR(50),
    transaction_type VARCHAR(10),
    amount DECIMAL(10,2),
    transaction_date DATE
);
INSERT INTO transactions
(transaction_id, transaction_name, transaction_type, amount, transaction_date)
VALUES
(1, 'Rahul', 'Credit', 5000.00, '2026-09-01'),
(2, 'Priya', 'Debit', 2500.00, '2026-09-02'),
(3, 'Arjun', 'Credit', 7500.00, '2026-09-03'),
(4, 'Sneha', 'Debit', 1800.00, '2026-09-04'),
(5, 'Kiran', 'Credit', 6200.00, '2026-09-05');

SELECT * FROM transactions;

create table audit_transactions(
	audit_id int auto_increment primary key,
    transaction_id int,
    account_name varchar(50),
    transaction_type varchar(50),
    amount decimal(10,2),
    action_type varchar(50),
    action_time timestamp default current_timestamp
    );
    
delimiter //
create trigger after_transaction_insert
after insert on transactions
for each row 
begin 
	insert into audit_transactions
    (transaction_id,account_name,transaction_type,amount,action_type)
    values
    (new.transaction_id,new.account_name,new.transaction_type,new.amount,"insert");
end//
delimiter //
INSERT INTO transactions
(transaction_id, account_name, transaction_type, amount, transaction_date)
VALUES
(10, 'Pavi', 'Credit', 6000.00, '2026-09-12');

SELECT * FROM audit_transactions;

DELIMITER //

CREATE TRIGGER after_transaction_updated
AFTER UPDATE ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO audit_transactions_
    (transaction_id,account_name,transaction_type,amount,action_type)
    VALUES
    (NEW.transaction_id,
     NEW.account_name,
     NEW.transaction_type,
     NEW.amount,
     'UPDATE');
END //

UPDATE transactions
SET amount = 6520.00
WHERE transaction_id = 3;

SELECT * FROM audit_transactions;

DELIMITER //

CREATE TRIGGER after_transaction_deleted
AFTER DELETE ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO audit_transactions
    (transaction_id,account_name,transaction_type,amount,action_type)

    VALUES
    (OLD.transaction_id,
     OLD.account_name,
     OLD.transaction_type,
     OLD.amount,
     'DELETE');
END //

DELIMITER ;
DELETE FROM transactions
WHERE transaction_id = 17;

SELECT * FROM audit_transactions;
SELECT * FROM audit_transactions;
 