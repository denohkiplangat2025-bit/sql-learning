--        STRING functions
--String Fuctions
--            1. CONCAT
--combines multiple strings into one
--show a list of customers first names together with their country in one column
SELECT
first_name,
country,
CONCAT(first_name,'-',country) AS name_country
FROM customers

            --2.LOWER
--converts all characters to lowercase
--tranform the customer's first name to lowercase
SELECT
first_name,
LOWER(first_name) AS low_name
FROM customers

--3.UPPER
--coverts all characters to uppercase
--transform the customer's first name to uppercase
SELECT
first_name,
UPPER(first_name) AS up_name
FROM customers

--4.TRIM
--removes leading and trailing spaces
/*find customers whose first name contains leading or trailing 
spaces*/
SELECT
first_name
FROM customers
WHERE first_name != TRIM(first_name);

SELECT
first_name,
LEN(TRIM(first_name)) len_trim_name,
LEN(first_name)- LEN(TRIM(first_name)) flag
FROM customers
WHERE LEN(first_name) !=LEN(TRIM(first_name))

--       5.REPLACE
--replaces specific character with a new character
--replace dashes(-) from a phone number to (/)
SELECT
'123-456-7890'AS phone,
REPLACE('123-456-7890','-','/') AS clean_phone

--       6.LEN
--counts how many characters
--calculate the length of each customer's first name
SELECT 
first_name,
LEN(first_name) AS len_name
FROM customers

--           7.LEFT
--retrieve the first two characters of each first name
SELECT
first_name,
LEFT(TRIM(first_name),2)first_2_char
FROM customers

--          7.RIGHT
--extracts specific number of characters from the end
--retrieve the last two characters of each first name
SELECT
first_name,
RIGHT(TRIM(first_name),2) last_2_char
FROM customers

--             9.SUBSTRING
--extracts a part of string at a specified position.
/*retrieve a list of customers' first names after removing
  the first character*/
  SELECT
  first_name,
  SUBSTRING(TRIM(first_name),2,LEN(TRIM(first_name)) AS sub_name
  FROM customers