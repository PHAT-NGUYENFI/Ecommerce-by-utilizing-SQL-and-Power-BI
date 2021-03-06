/*Number of the record in the data*/
SELECT count(dbo.Ecommerce.invoice_num)
FROM dbo.Ecommerce;

/*Number of unique invoice number, unique customers, unique stockcode*/
SELECT 	COUNT(DISTINCT dbo.Ecommerce.invoice_num),
	COUNT(DISTINCT dbo.Ecommerce.cust_id),
	COUNT(DISTINCT dbo.stock_code)
FROM dbo.Ecommerce;

/*Check whether one stockcode appear once in one invoice*/ And the answer is NO
SELECT 	dbo.Ecommerce.stock_code, 
	dbo.Ecommerce.invoice_num, count(*)
FROM dbo.Ecommerce
GROUP BY stock_code, invoice_num
HAVING COUNT(*) > 1;

/*Change type of quantity to int*/
ALTER TABLE dbo.Ecommerce
ALTER COLUMN quantity int;

/*Change type of Unit price to decimal*/
ALTER TABLE dbo.Ecommerce
ALTER COLUMN unit_price decimal(10,3);

/*Change type of amount spent to decimal*/
ALTER TABLE dbo.Ecommerce
ALTER COLUMN unit_price decimal(10,3);

/*Monthly revenue and number of order*/
SELECT		YEAR(dbo.Ecommerce.invoice_date) AS YEAR, 
		MONTH(dbo.Ecommerce.invoice_date) AS MONTH,
		CAST(SUM(dbo.Ecommerce.amount_spent) AS decimal(10,2)) AS Monthly_revenue,
		COUNT(distinct invoice_num) AS Monthly_Number_of_order
FROM dbo.Ecommerce
GROUP BY YEAR(dbo.Ecommerce.invoice_date), MONTH(dbo.Ecommerce.invoice_date)
ORDER BY YEAR, MONTH;

WITH CTE_2 AS 
		(
		SELECT	dbo.Ecommerce.stock_code,
			CAST(SUM(dbo.Ecommerce.amount_spent) AS decimal(10,2)) AS Revenue
		FROM dbo.Ecommerce
		GROUP BY dbo.Ecommerce.stock_code
		)
SELECT	A.stock_code,
	A.Revenue,
	CAST(SUM(B.Revenue)*100/(SELECT SUM(Revenue) FROM CTE_2) AS decimal(10,2)) AS '%cumulative'
FROM CTE_2 AS A, CTE_2 AS B
WHERE A.Revenue <= B.Revenue OR (A.Revenue = B.Revenue AND A.stock_code = B.stock_code)
GROUP BY A.Revenue, A.stock_code
ORDER BY A.Revenue DESC

/*Revenue/ % revenue/ Number of orders/ Average Order Value/Customer lifetime value  by country*/
WITH CTE_4 AS
(SELECT	Sub.Country_Groups,
	COUNT(DISTINCT Sub.invoice_num) AS Number_of_orders,
	COUNT(DISTINCT Sub.cust_id) AS Number_of_customers,
	CAST(SUM(Sub.amount_spent) AS decimal(10,2)) AS Revenue
FROM 
			(
			SELECT	dbo.Ecommerce.invoice_num,
				dbo.Ecommerce.cust_id,
				dbo.Ecommerce.amount_spent,
				CASE
				WHEN dbo.Ecommerce.country = 'United Kingdom' THEN 'United Kingdom'
				WHEN dbo.Ecommerce.country = 'Netherlands' THEN 'Netherlands'
				WHEN dbo.Ecommerce.country = 'EIRE' THEN 'EIRE'
				WHEN dbo.Ecommerce.country = 'Germany' THEN 'Germany'
				WHEN dbo.Ecommerce.country = 'France' THEN 'France'
				WHEN dbo.Ecommerce.country = 'Australia' THEN 'Australia'
				ELSE 'OTHER'
				END AS Country_Groups
			FROM dbo.Ecommerce
			) AS Sub	
GROUP BY Sub.Country_Groups)
SELECT	A.Country_Groups,
	A.Number_of_orders,
	A.Number_of_customers,
	A.Revenue,
	CAST(A.Revenue*100/(SELECT Sum(CTE_4.Revenue) FROM CTE_4) AS decimal(10,2)) AS '%',
	CAST(A.Revenue/A.Number_of_orders AS decimal(10,2)) AS Average_Order_Size,
	CAST((A.Number_of_orders/A.Number_of_customers)*(A.Revenue/A.Number_of_orders) AS decimal(10,2)) AS Customer_lifetime_value
FROM CTE_4 AS A, CTE_4 AS B
WHERE A.Country_Groups = B.Country_Groups
GROUP BY A.Country_Groups, A.Number_of_customers, A.Number_of_orders, A.Revenue
ORDER BY A.Revenue DESC;

/*Number of repeat customers by month*/
SELECT	B.YEAR,
		B.MONTH,
		COUNT(B.Repeat_consumer) AS Number_of_repeat_consumer,
		COUNT(B.One_time_consumer) AS Number_of_one_time_consumer
FROM
			(SELECT	Sub.YEAR,
				Sub.MONTH,
				Sub.cust_id,
				CASE
				WHEN COUNT(*) > 1 THEN COUNT (Sub.cust_id) END AS Repeat_consumer,
				CASE
				WHEN COUNT(*) = 1 THEN COUNT (Sub.cust_id) END AS One_time_consumer
			FROM 
						(SELECT 	DISTINCT YEAR(dbo.Ecommerce.invoice_date) AS YEAR, 
								MONTH(dbo.Ecommerce.invoice_date) AS MONTH,
								dbo.Ecommerce.cust_id, 
								dbo.Ecommerce.invoice_num
						FROM dbo.Ecommerce
						) AS Sub
			GROUP BY Sub.cust_id, Sub.YEAR, Sub.MONTH) AS B
GROUP BY B.YEAR, B.MONTH
ORDER BY B.YEAR, B.MONTH