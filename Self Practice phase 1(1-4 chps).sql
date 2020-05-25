select * from vendors;
select * from invoices;
select * from terms;
select * from invoice_line_items
select * from vendor_contacts
select * from general_ledger_accounts


select * from customers
select * from employees



SELECT invoice_number, invoice_date, invoice_total,
    payment_total, credit_total,
    invoice_total - payment_total - credit_total 
    AS balance_due
FROM invoices 
WHERE invoice_total - payment_total - credit_total > 0
ORDER BY invoice_date

select invoice_id,invoice_total+credit_total as credit_total
from invoices
where invoice_id = 17

select invoice_number,invoice_date,invoice_total
from invoices
where invoice_date between'2018-06-01' AND '2018-06-30'
ORDER BY invoice_date

select invoice_id,
invoice_id + 7 * 3 AS multiply_first, 
       (invoice_id + 7) * 3 AS add_first
FROM invoices

select invoice_id,
invoice_id / 3 as decimal_quotient,
invoice_id DIV 3 as integee_quotient,
invoice_id % 3 as remainder
from invoices

SELECT vendor_name,
CONCAT(vendor_city, ', ', vendor_state, ',',vendor_zip_code) AS address
FROM vendors

select concat(vendor_name, '''s , Address: ') AS Vendor,
CONCAT(vendor_city, ', ', vendor_state, ' ',vendor_zip_code) AS Address
FROM vendors

SELECT vendor_contact_first_name, vendor_contact_last_name,
    CONCAT(LEFT(vendor_contact_first_name, 1), 
           LEFT(vendor_contact_last_name, 1)) AS initials
FROM vendors

SELECT invoice_date,
  DATE_FORMAT(invoice_date, '%m/%d/%y') AS 'MM/DD/YY',
  DATE_FORMAT(invoice_date, '%e-%b-%Y') AS 'DD-Mon-YYYY'
FROM invoices


SELECT "Ed" AS first_name, "Williams" AS last_name,
    CONCAT(LEFT("Ed", 1), LEFT("Williams", 1)) AS initials


select distinct vendor_city,vendor_state
from vendors
order by vendor_city

select vendor_name,vendor_state 
from vendors
where vendor_state = 'WI' and vendor_city = 'Madison'


select vendors.vendor_id, vendors.vendor_name, invoices.invoice_total - invoices.payment_total - invoices.credit_total as balance_due
from vendors
left join invoices on vendors.vendor_id = invoices.vendor_id
where (invoice_due_date = '2018-07-28' or invoice_total > 500) 
having balance_due >  0

select invoice_date,invoice_total,payment_total,credit_total
from invoices
WHERE invoice_date > '2018-07-03' OR invoice_total > 500
  AND invoice_total - payment_total - credit_total > 0

select terms_id , terms_description , terms_due_days
from terms
where terms_id in (1,3,5)

select vendor_id 
from vendors
WHERE vendor_id IN
    (SELECT vendor_id
     FROM invoices
     WHERE invoice_date = '2018-07-18')

## Same output but used joins instead.

select vendors.vendor_id
from vendors
join invoices on vendors.vendor_id = invoices.vendor_id
WHERE invoice_date = '2018-07-18'

select distinct vendor_city
from vendors
WHERE vendor_city REGEXP 'on'

select distinct vendor_city
from vendors
WHERE vendor_city REGEXP '^Wa'

select distinct vendor_state
from vendors
where vendor_state regexp '[C | P ]A'

select vendor_city 
from vendors
where vendor_city regexp '[A-Z][AEIOU]N$'

SELECT vendor_name,
    CONCAT(vendor_city, ', ', vendor_state, ' ',
    vendor_zip_code) AS address
FROM vendors
ORDER BY CONCAT(vendor_contact_last_name,
                vendor_contact_first_name)

SELECT vendor_name,
    CONCAT(vendor_city, ', ', vendor_state, ' ',
    vendor_zip_code) AS address
FROM vendors
ORDER BY 2, 1

SELECT vendor_id, invoice_total
FROM invoices
ORDER BY invoice_total DESC
LIMIT 5

SELECT invoice_id, vendor_id, invoice_total
FROM invoices
ORDER BY invoice_id
LIMIT 100, 3

## Start chapter 4

SELECT invoice_number, vendor_name
FROM vendors  inner JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id
ORDER BY invoice_number

select invoice_number, line_item_amount, line_item_description
from invoices i join invoice_line_items i_line_items
on i.invoice_id = i_line_items.invoice_id
where account_number = 540
order by invoice_date

select vendor_name,customer_last_name,customer_first_name,vendor_state as state,vendor_city as city
from vendors v join om.customers c
on v.vendor_zip_code = c.customer_zip
ORDER BY state, city


SELECT customer_first_name, customer_last_name
FROM customers c JOIN ex.employees e 
    ON c.customer_first_name = e.first_name 
   AND c.customer_last_name = e.last_name

SELECT DISTINCT v1.vendor_name, v1.vendor_city, 
    v1.vendor_state
FROM vendors v1 JOIN vendors v2
    ON v1.vendor_city = v2.vendor_city AND
       v1.vendor_state = v2.vendor_state AND
       v1.vendor_name <> v2.vendor_name
ORDER BY v1.vendor_state, v1.vendor_city

select vendor_name, invoice_number, invoice_date, line_item_amount, account_description 
from vendors v
join invoices i on v.vendor_id = i.vendor_id
join invoice_line_items i_l on i.invoice_id = i_l.invoice_id
join general_ledger_accounts g on i_l.account_number = g.account_number
WHERE invoice_total - payment_total - credit_total > 0
order by vendor_name, line_item_amount desc

select vendor_name, invoice_number, invoice_date, line_item_amount, account_description 
from vendors v, invoices i , invoice_line_items i_l , general_ledger_accounts g
where v.vendor_id = i.vendor_id and i.invoice_id = i_l.invoice_id and i_l.account_number = g.account_number 
and  invoice_total - payment_total - credit_total > 0
order by vendor_name, line_item_amount desc

select vendor_name, invoice_number,invoice_total
from vendors v
left join invoices i on v.vendor_id = i.vendor_id

select * from employees
select * from departments
select * from projects

select department_name, d.department_number,last_name
from departments d 
left join employees e on d.department_number = e.department_number
order by department_name

select department_name, employees.department_number,last_name
from departments 
right join employees on departments.department_number = employees.department_number
order by department_name 

select department_name, last_name, project_number
from departments d
left join employees e on d.department_number = e.department_number
left join projects p on e.employee_id = p.employee_id
order by department_name

select department_name, last_name, project_number
from departments d
join employees e on d.department_number = e.department_number
left join projects p on e.employee_id = p.employee_id
order by department_name,last_name

select invoice_number,vendor_name
from invoices 
join vendors using (vendor_id)
ORDER BY invoice_number

select department_name,last_name,project_number
from departments d
join employees e using (department_number)
left join projects p using (employee_id)
order by department_name

select invoice_number,vendor_name
from invoices 
natural join vendors 
order by invoice_number

select department_name as dept_name, last_name,project_number
from departments d 
natural join employees e 
left join projects p on e.employee_id = p.employee_id
order by department_name

