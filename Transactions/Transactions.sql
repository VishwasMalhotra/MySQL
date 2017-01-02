CREATE DATABASE bank;
use bank;

CREATE TABLE users(
	id INT AUTO_INCREMENT,
	`name` VARCHAR(30),
	email VARCHAR(30),
	account_no INT unsigned,
	PRIMARY KEY(id, account_no)
);

CREATE TABLE accounts(
	id INT AUTO_INCREMENT,
	bank_account_no INT,
	balance INT unsigned,
	PRIMARY KEY(id),
	FOREIGN KEY(bank_account_no) REFERENCES users(account_no)
);

INSERT INTO users (name, email, account_no)
	VALUES('userA', 'userA@xyz.com', 97171),
	('userB', 'userB@abc.com', 99535);

INSERT INTO accounts (bank_account_no, balance)
	VALUES(97171, 25000),
	(99535, 18000);


START TRANSACTION;

--i) userA is depositing 1000 Rs. his account
UPDATE accounts
SET balance = balance + 1000
WHERE bank_account_no = 97171;

--ii) userA is withdrawing 500 Rs.
UPDATE accounts
SET balance = balance - 500
WHERE bank_account_no = 97171;

--iii) userA is transferring 200 Rs to userB's account
UPDATE accounts
SET balance =(case when bank_account_no = 97171 then balance - 200
when bank_account_no = 99535 then balance + 200
end)
WHERE bank_account_no IN (97171,99535);

COMMIT;
