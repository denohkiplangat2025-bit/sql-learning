-- Create a new table called persons with columns:id, person_name, birth_date, and phone

CREATE TABLE persons(
id INT NOT NULL,
person_name VARCHAR(50) NOT NULL,
birth_date DATE,
phone VARCHAR(15) NOT NULL,
CONSTRAINT pk_persons PRIMARY KEY (id)
)

-- Add a new column called email to the persons table

ALTER TABLE persons
ADD email VARCHAR (50) NOT NULL

-- Data Manipulation Langauage DML Commands 

INSERT INTO customers(id,first_name,country,score)
VALUES
       (6,'Anna','USA',NULL),
       (7,'Sam',NULL,100)

 -- Insert data from 'customers' into 'persons'

INSERT INTO persons (id,person_name,birth_date,phone)
SELECT
id,
first_name,
NULL,
'Unknown'
FROM customers

-- Update all customers with a NULL score by setting their score to 0
UPDATE customers
SET score = 0
WHERE score IS NULL

-- Change the score of customer 10 to 0 and update the country to UK
UPDATE customers
SET score = 0,
country = 'UK'
WHERE id = 10

-- Change the score of customer 6 to 0
UPDATE customers
SET score = 0
WHERE id = 6

-- Delete all customers with an ID greater than 5.
DELETE FROM customers
WHERE id>5

-- Remove the column phone from the persons table
ALTER TABLE persons
DROP COLUMN phone

-- Delete all data from table persons
TRUNCATE TABLE persons

-- Delete the table persons from the database
DROP TABLE persons
