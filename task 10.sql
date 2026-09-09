use coa_alriya;
CREATE TABLE monthly_sales (
    sale_month DATE,
    customer_name VARCHAR(50),
    sales DECIMAL(12,2)
);

INSERT INTO monthly_sales (sale_month, customer_name, sales)
VALUES
('2023-01-01', 'Arun', 100000),
('2023-02-01', 'Bala', 120000),
('2023-03-01', 'Arun', 110000),
('2023-04-01', 'Divya', 150000),
('2023-05-01', 'Bala', 130000),
('2023-06-01', 'Arun', 140000),
('2023-07-01', 'Divya', 150000),
('2023-08-01', 'Bala', 160000),
('2023-09-01', 'Arun', 140000),
('2023-10-01', 'Divya', 180000),
('2023-11-01', 'Bala', 170000),
('2023-12-01', 'Arun', 160000),

('2024-01-01', 'Arun', 130000),
('2024-02-01', 'Bala', 150000),
('2024-03-01', 'Arun', 140000),
('2024-04-01', 'Divya', 170000),
('2024-05-01', 'Bala', 160000),
('2024-06-01', 'Arun', 155000),
('2024-07-01', 'Divya', 180000),
('2024-08-01', 'Bala', 175000),
('2024-09-01', 'Arun', 165000),
('2024-10-01', 'Divya', 190000),
('2024-11-01', 'Bala', 185000),
('2024-12-01', 'Arun', 175000);

SELECT * FROM monthly_sales;




select sale_month,customer_name,sales,
     rank() over(order by sales desc) as sales_rank
from monthly_sales;

select sale_month,customer_name,sales,
     dense_rank() over(order by sales desc) as sales_dense_rank
from monthly_sales;

select sale_month,customer_name,sales,
     row_number() over(order by sales desc) as sales_row_number
from monthly_sales;

select sale_month,sales,
      lag(sales) over ( order by sale_month) as previous_month_sales
from monthly_sales;

select sale_month,sales,
      lead(sales) over ( order by sale_month) as next_month_sales
from monthly_sales;

select sale_month,sales,
      lag(sales,12) over ( order by sale_month) as previous_year_sales
from monthly_sales;

select sale_month,sales,
      lead(sales,12) over ( order by sale_month) as next_year_sales
from monthly_sales;

select sale_month,sales,sum(sales) over (order by  sale_month) as running_total from monthly_sales;

select sale_month,sales,lag(sales,12) over (order by sale_month) as previous_year_sales,
((sales-lag(sales,12) over (order by sale_month))/lag(sales,12) over (order by sale_month))*100 as yoy_growth
from monthly_sales;

select sale_month,customer_name,sales, 
rank() over(order by sales desc) as sales_rank,
dense_rank() over(order by sales desc) as sales_dense_rank,
row_number() over(order by sales desc) as sales_row_number,
lag(sales) over ( order by sale_month) as previous_month_sales,
lead(sales) over ( order by sale_month) as next_month_sales
from monthly_sales;

