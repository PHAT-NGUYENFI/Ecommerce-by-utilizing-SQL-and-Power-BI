# Ecommerce-by-utilizing-SQL-and-Power-BI
## 1. Overview about the data
- The period of the date is from 01st DEC 2010 to 09th DEC 2011
- The dataset contains information about the sales activities of thousands of products in Ecommerce indsutry
- The table below demonstrates the columns and data type of each column

| Column Name        | Data type  |
| ------------- |:-------------:|
| Invoice_num      | int, not null|
| Invoice_date      | date, not null|
| Year_month      | varchar(50), not null|
| month      | int, not null|
| day      | int, not null|
| hour      | int, not null|
| stock_code      | varchar(50), not null|
| description      | varchar(50), not null|
| quantity      | varchar(50), null|
| unit_price      |varchar(50), null|
| amount_spent      | varchar(50), null|
| cust_id     | int, not null|
| country     |varchar(50), not null|
## 2. Objectives of exploratory data analysis (EDA)
- The EDA will evaluate the performance of different metrics, which are usually utilized in Ecommerce industry. The list of metrics will be mentioned in next session.
- Through data visualization, the project offers insights regarding the KPIs, which is useful to come up with the solutions to enhance the development of the company
- This project reflects how to apply advanced queries writing, such as subquery, common table expression (CTE), etc.
## 3. List of KPIs in this project
- **Monthly revenue**
- **Monthly number of orders**
- **Frequency of ordering**: this metrics shows how often one unique customer order on a period of time. It is calculated by dividing the number of orders to the number of unique customers in a period of time.
- **Repeat customer rate**: the percentage of customers making multiple orders compared to total number of unique customers in a certain period of time
- **Average Order Value (AOV)**: the average amount of one order in the certain period of time. It is calculated by dividing the total number of sales revenue to total number of orders in a period of time.
- **Customer lifetime value (CLV)**: It is the total worth to a business of a customer over the whole period of time. This is how it is calculated: AOV * (average number of orders of one customer makes in a period of time). CLV is not only a measurement of purchase-by-purchase basis, but also how valuable a customer is to the company.
## 4. How to conduct the EDA to assess the KPIs
SQL and Power BI are mainly utilized in this project. Data will be retrieved from the dataset then visualized through Power BI. The result of this project can be found in the **"Exploratory Data Analysis.pdf"**
- Perform EDA to have the overview about the data (time period, number of record, number of unique invoices, unique customers, countries, stockcode)
- Check duplicate record (for exampple, check whether one stock code appears more than one in one invoice number)
- Retrieve the data and create the graphs to see how revenue, number of orders, repeat customer rate change over the period. Recognize the trend of these charts and hypothesizing why these metrics perfomed that way.
- Retrieve the data and visualize the result to gain insight how stockcode affects to the sales revenue (i.e using ABC analysis to categorize the importance of group of stockcode based on the contribution of them to the total revenue). The company has to manage thousands of items, however, it is unwise if the company allocates the resource in managing stockcode equally. This analysis will help the company to determine which products they should focus on, i.e demand forecast, inventory management, etc.
- Retrieve the data to have information about the performance to sales revenue by country. An interesting point is discovered from the data that We can create the countries group for a better EDA.
- Group countries, retrieve the data to evaluate the KPIs: monthly revenue, number of orders, AOV, CLV by country. Visualize the result in Power BI and try to figure out which kind of segment, which kind of products( high-end or low-end or medium price) that the company should focus on in each group of country
- Synthesize and propose the solution to improve KPIs 
## 5. Notes
- This project is the reflection of what I have studied. Any comments or constructive feedbacks are highly appreciated
