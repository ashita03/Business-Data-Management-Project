/* Online orders by brand & Product line */
SELECT COUNT(online_order) AS number_of_online_orders, brand, product_line FROM transactions
WHERE online_order = 'TRUE'
GROUP by brand, online_order, product_line
ORDER by brand, product_line;

/* Top 10 customers with most number of transactions */
SELECT COUNT(ts.transaction_id) AS no_of_transactions, cd.customer_id FROM transactions ts 
LEFT JOIN cust_demographic cd
ON ts.customer_id = cd.customer_id
GROUP BY ts.brand, cd.customer_id
ORDER BY COUNT(ts.transaction_id) desc
LIMIT 10;

/* Segregation of users based on their Wealth Segment & comparison with total number of transactions*/
SELECT COUNT(DISTINCT(cd.customer_id)) AS count_of_customers, 
	COUNT(ts.transaction_id) AS count_of_transactions, 
	cd.wealth_segment 
	FROM cust_demographic cd
LEFT JOIN transactions ts
ON ts.customer_id = cd.customer_id
GROUP BY wealth_segment
ORDER BY wealth_segment;

/* State wise distribution of Customers from Customer Address */
SELECT COUNT(customer_id) AS distribution_of_customers, state FROM cust_address
GROUP BY state
ORDER BY state;

/* Age wise distribution of transactions of different cycle brands */
/*Based on the new age group created in the cust_demographic table (refer data_cleaning.sql), we carry out this analysis */
SELECT
  t.brand,
  CASE
	WHEN age_column< 18 THEN 'Under 18'
	WHEN age_column BETWEEN 18 AND 29 THEN '18-29'
	WHEN age_column BETWEEN 30 AND 39 THEN '30-39'
	WHEN age_column BETWEEN 40 AND 49 THEN '40-49'
	WHEN age_column BETWEEN 50 AND 59 THEN '50-59'
	WHEN age_column >= 60 THEN '60 and over'
	ELSE 'Unknown'  -- Handle any unexpected cases
  END AS age_group,
  COUNT(*) AS total_transactions
FROM transactions t
JOIN cust_demographic cd
ON cd.customer_id = t.customer_id
GROUP BY t.brand, age_group
ORDER BY t.brand, age_group;

/* State wise and age group wise distribution of new users*/
SELECT state, 
	CASE
		WHEN age_column< 18 THEN 'Under 18'
		WHEN age_column BETWEEN 18 AND 29 THEN '18-29'
		WHEN age_column BETWEEN 30 AND 39 THEN '30-39'
		WHEN age_column BETWEEN 40 AND 49 THEN '40-49'
		WHEN age_column BETWEEN 50 AND 59 THEN '50-59'
		WHEN age_column >= 60 THEN '60 and over'
		ELSE 'Unknown'  -- Handle any unexpected cases
  	END AS age_group,
	COUNT(first_name) AS count_new_users
  	FROM new_cust_list
GROUP BY state, age_group
ORDER BY state, age_group;

/* Maximum and Minimum Transaction Value */
SELECT CONCAT('$',MAX(list_price)) AS max_list_price, CONCAT('$',MIN(list_price)) AS min_list_price FROM transactions;






