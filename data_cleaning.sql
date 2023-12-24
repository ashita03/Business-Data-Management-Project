/* We figured there are NULL values in Brand & Product line in Transactions table, so we deal with those columns */
UPDATE transactions
SET brand='Others'
WHERE brand = '';

UPDATE transactions
SET product_line='Undefined'
WHERE product_line = '';

/* Cleaning the Gender column in the Customer Demographic table */
SELECT DISTINCT(gender) FROM cust_demographic;

UPDATE cust_demographic
SET gender='Female'
WHERE gender = 'F';

UPDATE cust_demographic
SET gender='Female'
WHERE gender = 'Femal';

UPDATE cust_demographic
SET gender='Male'
WHERE gender = 'M';

UPDATE cust_demographic
SET gender='Others'
WHERE gender = 'U';

/* Cleaning the empty job titles */

SELECT COUNT(job_title) AS no_of_empty_job_titles FROM cust_demographic
WHERE job_title = '';

UPDATE cust_demographic
SET job_title='Not Updated'
WHERE job_title = '';

UPDATE new_cust_list
SET job_title='Not Updated'
WHERE job_title = '';

SELECT COUNT(job_title), job_title FROM cust_demographic
GROUP BY job_title
ORDER BY job_title;

/* Cleaning the state column in Customer Address */
SELECT DISTINCT(state) FROM cust_address;

UPDATE cust_address
SET state='Queensland'
WHERE state = 'QLD';

UPDATE cust_address
SET state='Victoria'
WHERE state = 'VIC';

UPDATE cust_address
SET state='New South Wales'
WHERE state = 'NSW';

/*Maintaining consistency for New users state */
SELECT DISTINCT(state) FROM new_cust_list;

UPDATE new_cust_list
SET state='Queensland'
WHERE state = 'QLD';

UPDATE new_cust_list
SET state='Victoria'
WHERE state = 'VIC';

UPDATE new_cust_list
SET state='New South Wales'
WHERE state = 'NSW';

/* Creating an Age column in Customer Demographics and New customer list*/
ALTER TABLE cust_demographic
ADD COLUMN age_column INTEGER;

UPDATE cust_demographic
SET age_column = 
  CASE 
    WHEN dob <> '' AND dob IS NOT NULL AND dob::date IS NOT NULL 
    THEN EXTRACT(YEAR FROM AGE(dob::date))
    ELSE NULL
  END;
  
ALTER TABLE new_cust_list
ADD COLUMN age_column INTEGER;

UPDATE new_cust_list
SET age_column = 
  CASE 
    WHEN dob <> '' AND dob IS NOT NULL AND dob::date IS NOT NULL 
    THEN EXTRACT(YEAR FROM AGE(dob::date))
    ELSE NULL
  END;
  
SELECT * FROM new_cust_list



