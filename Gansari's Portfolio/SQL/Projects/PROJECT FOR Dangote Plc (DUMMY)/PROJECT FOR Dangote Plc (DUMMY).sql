
-- case 1--
-- Average Invoice Value by Customer
-- Finance Director
Williams, I want to understand our average transaction size.
Produce a report showing:
Customer Name
Number of Invoices
Average Invoice Amount
Maximum Invoice Amount
Minimum Invoice Amount
Order from highest average invoice value to lowest.
;
select  i.customer_id, c.`name` as `Name`,
count(invoice_id) No_of_invoices,  
avg(i.total) Avg_invoice,
max(i.total) Max_invoice,
min(i.total) Min_invoice
from invoices as I
join customers as C
	ON I.customer_id = C.customer_id
group by i.customer_id
order by 5 desc
;


;
-- Case Study 2 – Customer Revenue Analysis
“Management wants to know our biggest customers.
Calculate the total invoiced amount for every customer.
Display:
* Customer Name
* Total Sales
-- Sort from highest to lowest.”
;
select   cus.`name`as `Names` , Inv.customer_id as Customers_id 
, sum(total) as Total_sales
from invoices as Inv 
join customers as Cus
	ON    Inv.customer_id = Cus.customer_id
group by Inv.customer_id
order by Total_sales desc;

-- top 3 customers --

select   cus.`name`as `Names` , Inv.customer_id as Customers_id 
, sum(total) as Total_sales
from invoices as Inv 
join customers as Cus
	ON    Inv.customer_id = Cus.customer_id
group by Inv.customer_id
order by Total_sales desc
limit 3;


-- case 3--
-- Collections Report
“The CFO wants to know how much cash has actually been received.
Produce a report showing:
* Customer Name
* Total Invoiced
* Total Payments Received”
;

select  inv.customer_id, cus.`name` Customer_name, sum(inv.total) Total_sales, sum( pay.amount)
Amount_paid
from invoices as Inv   
join customers as Cus
	ON    Inv.customer_id = Cus.customer_id
left join payments as Pay
	on Pay.invoice_id= inv.invoice_id
group by inv.customer_id
;


-- case 4 -- 
-- Case Study 4 – Outstanding Balances
-- “Prepare a list of customers who still owe us money.
Show:
* Customer Name
* Total Invoiced
* Total Paid
* Outstanding Balance”
;

with Total_invoice as
(
select i.customer_id, sum(i.total) as Total_invoice , c.`name` 
from invoices as I
join customers as C
	ON I.customer_id = C.customer_id
group by customer_id
),

Total_invoice_paid as 
(
select i.customer_id, sum(i.total) as Total_paid, `status`
from invoices as I
join customers as C
	ON I.customer_id = C.customer_id
where `status` = 'paid'
group by customer_id
)

select t.`name`, t.customer_id, t.total_invoice as Total_invoice, tp.Total_paid,
 (t.total_invoice - tp.Total_paid) as Balance
from Total_invoice as T
join Total_invoice_paid AS TP
	ON T.customer_id = TP.customer_id

-- personal notes: ican do computations like this when you already have the columns 

-- case 5 --
-- Case Study 5 – Monthly Sales Report
“We’re reviewing monthly performance.
Calculate total invoices issued each month.”
;
select
substring(invoice_date, 6,2) as Months,
sum(total) as Sales_per_month
from invoices
group by Months
order by 1 asc
;

-- case 6 -- 
Case Study 6 – Top 10 Customers
“Show our ten highest-paying customers based on invoice value.”
-- top 10 customers, based on invoice values
;
select  i.customer_id, c.`name` as `Name`, sum(i.total) as Total_sales 
from invoices as I
join customers as C
	ON I.customer_id = C.customer_id
group by i.customer_id
order by 3 desc
limit 10;



-- case 7-- 
Case Study 7 – Cash Received by Month
“Prepare the monthly cash collection report using the Payments table.”;

select  substring(payment_date, 6,2) as Months, sum(amount) Cash_received
from  payments 
group by Months
order by 1 asc ;


-- case 8 --
Case Study 8 – Customers by City
“Management wants to know where our customers are located.
Count customers in each city.”;

select city City , count(`name`) Number_of_customers
from customers
group by city ;

-- case 9--
Case Study 9 – Journal Review
“Internal Audit is reviewing journal entries.
Display every journal entry together with all debit and credit lines.”
;


select line_id, account, debit, credit
from journal_lines;

-- case 10 -- 
-- Case Study 10 – Trial Balance
“Prepare a trial balance from the journal lines.
For every account, calculate:
* Total Debit
* Total Credit”
;
select entry_id, account, debit, credit
from journal_lines;

select sum(debit) Debit, sum(credit) Credit
from journal_lines
group by `account`;

-- case 11 --
-- Case Study 11 – Customers Who Have Never Paid
Email from Accounts Receivable Manager
Williams,
We are reviewing customer credit risk.
Please identify customers who have invoices but have never made a payment.
Display:
Customer ID
Customer Name
Number of Invoices
Total Amount Invoiced
Sort by the highest invoiced amount.
;

select  I.customer_id, 
`name`, 
count(i.invoice_id) No_of_invoices, 
sum(total) Total
from invoices I
join customers C
	ON I.customer_id=C.customer_id
left join payments P
	 ON I.invoice_id = P.invoice_id
where status = 'unpaid' and P.amount is null
group by I.customer_id
order by 4 desc
;







-- Other cases -- 
select  i.customer_id, c.`name` as `Name`,  
sum(i.total) sum_invoice
from invoices as I
join customers as C
	ON I.customer_id = C.customer_id
group by i.customer_id
;

select customer_id, 
avg(total) over() 
from invoices
group by customer_id

;


select
    c.customer_id,
    c.name AS customer_name,
    COUNT(i.invoice_id) AS number_of_invoices,
    SUM(i.total) AS total_amount_invoiced
FROM customers c
JOIN invoices i
    ON c.customer_id = i.customer_id
WHERE NOT EXISTS (
    SELECT 1
    FROM invoices i2
    JOIN payments p
        ON i2.invoice_id = p.invoice_id
    WHERE i2.customer_id = c.customer_id
)
GROUP BY
    c.customer_id,
    c.name
ORDER BY
    total_amount_invoiced DESC;


















select *
from  
(select  *
from invoices I
join customers C
	ON  I.customer_id = C.customer_id) as Tab


;


select *
from
( 
select *
FROM invoices as Inv
JOIN customers as Cus
	ON Inv.customer_id = Cus.customer_id
)

;













