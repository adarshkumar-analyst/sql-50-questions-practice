-- =========================
--  BASIC LEVEL (1–15)
-- =========================

-- Q1: Retrieve all employees
select * 
 from employees;

-- Q2: Show only name and salary columns
select name,
       salary
 from employees;      

-- Q3: Find employees with salary greater than 60000
select *
 from employees
   where salary>60000;

-- Q4: Get all employees who are from Delhi
select *
 from employees
  where city="Delhi";

-- Q5: Find employees working in the IT department
select *
 from employees
  where department="IT";

-- Q6: Sort employees by salary in ascending order
select *
 from employees
  order by salary asc;

-- Q7: Retrieve top 3 employees with highest salary
select *
 from employees
  order by salary desc
   limit 3;

-- Q8: List all distinct departments
select distinct department
 from employees;

-- Q9: Count total number of employees
select count(emp_id) as total_employees
 from employees;

-- Q10: Find the average salary of employees
select avg(salary) as Avg_Salary
 from employees;

-- Q11: Find the maximum salary
select max(salary) as max_salary
 from employees;

-- Q12: Find the minimum salary
select min(salary) as min_salary
 from employees;

-- Q13: Count employees in each department
select department,
	   count(emp_id) as total_employees	
from employees
group by department;       

-- Q14: Find average salary per department
select round(
	   avg(salary),2) as Avg_salary,
	   department
  from employees
  group by department;

-- Q15: Get employees whose salary is between 60000 and 80000
select * 
 from employees
  where salary between 60000 and 80000
  order by salary;


-- =========================
-- 🟡 INTERMEDIATE LEVEL (16–30)
-- =========================

-- Q16: Find employees earning more than average salary
select * 
 from employees
  where salary>(
                 select avg(salary)
                  from employees);

-- Q17: Find the second highest salary
select max(salary) as 2nd_highest_salary
 from employees
  where salary <( 
                  select max(salary)
                   from employees);

-- Q18: Find duplicate salaries in the table
select salary,
	   count(*) as count
 from employees
  group by salary
  having count(*)>1;

-- Q19: Count number of employees in each city
select city,
       count(*) as total_employees
 from employees
 group by city;

-- Q20: Get the most recently joined employee
select *
 from employees
  where join_date=(
                   select max(join_date)
                   from employees);

-- Q21: Find highest salary in each department
select department,
       max(salary) as highest_salary
from employees
group by department
order by highest_salary desc;        

-- Q22: Find lowest salary in each department
select department,
       min(salary) as lowest_salary
from employees
group by department
order by highest_salary asc;  

-- Q23: Rank employees based on salary (highest first)
select *,
       rank() over(order by salary desc) salary_rank
from employees;

-- Q24: Apply RANK() and DENSE_RANK() on salary
select *,
       rank() over(order by salary desc) Rank_Salary,
       dense_rank() over(order by salary desc) DenseRank_Salary
from employees;

-- Q25: Get top 2 highest salaries in each department
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk <= 2;
-- Q26: Find employees who have not placed any orders
select *
 from employees
  where emp_id not in (
                       select emp_id
                        from orders);

-- Q27: Find employees who have placed at least one order
select *
 from employees
  where emp_id  in (
                       select emp_id
                        from orders);


-- Q28: Count total orders per employee
select emp_id,
	   count(order_id) as total_orders
 from orders
 group by emp_id;

-- Q29: Calculate total revenue from orders table
select sum(amount) as revenue
 from orders;

-- Q30: Find employee who has placed the highest number of orders
select e.emp_id,
		count(o.order_id) as total_orders
from employees e
join orders o
on e.emp_id=o.emp_id
group by e.emp_id
order by total_orders desc
limit 1;
 

-- =========================
--  JOIN LEVEL (31–40)
-- =========================

-- Q31: Join employees and orders table
select *
from employees e 
join orders o 
on e.emp_id=o.emp_id;

-- Q32: Find total order amount for each employee
select e.emp_id,
       sum(o.amount) as revenue
 from employees e 
 join orders o 
 on e.emp_id=o.emp_id
 group by e.emp_id;

-- Q33: Display employee name along with order amount
select e.name,
       o.amount
 from employees e 
 join orders o 
 on e.emp_id=o.emp_id;
 
-- Q34: Find employees who never placed an order
select *
from employees e
left join orders o
on e.emp_id=o.emp_id
where o.emp_id is null;

-- Q35: Find employee who made the highest single order
select e.*,
	   o.amount
from employees e
join orders o
on e.emp_id=o.emp_id
where o.amount = (
                  select max(amount)
                  from orders);

-- Q36: Calculate department-wise total order amount
select d.dept_name,
	   sum(o.amount) as total_order_amt
from departments d
join employees e
on d.dept_name=e.department
join orders o 
on o.emp_id=e.emp_id
group by d.dept_name
order by total_order_amt desc;

-- Q37: Calculate city-wise total revenue
select e.city,
	   sum(o.amount) as total_revenue
from employees e
join orders o
on e.emp_id=o.emp_id
group by e.city;

-- Q38: Find employee who placed the most recent order
select e.* 
from employees e 
join orders o
on e.emp_id=o.emp_id
where o.order_date=(
                    select max(order_date)
                    from orders);

-- Q39: Count employees in each department
select d.dept_name,
        count(*) as total_emp
 from employees e
 join departments d
 on	e.department=d.dept_name
group by d.dept_name;

-- Q40: Join employees with departments table
select *
 from employees e
 join departments d
 on e.department=d.dept_name;


-- =========================
--  ADVANCED LEVEL (41–50)
-- =========================

-- Q41: Calculate running total of order amounts
select *,
sum(amount) over(order by order_date ) as running_total
from orders;

-- Q42: Calculate month-wise revenue
select date_format(order_date,'%Y-%m') as month,
        sum(amount) as Revenue
  from orders
  group by date_format(order_date,'%Y-%m')
  order by month;

-- Q43: Use LAG() to compare current order with previous order
select order_id,
       emp_id,
       order_date,
       amount,
       lag(amount) over(order by order_date) as pre_order
from orders;

-- Q44: Use LEAD() to compare current order with next order
select order_id,
       emp_id,
       order_date,
       amount,
       lead(amount) over(order by order_date) as next_order
    from orders;   

-- Q45: Calculate salary percentile
select emp_id,
        name,
        salary,
        round(
       percent_rank() over(order by salary),2) as percentile
       from employees;

-- Q46: Write a query to find nth highest salary
select *
from(
	  select *,
              dense_rank() over(order by salary desc) as  dense_rnk
              from employees)t
    where dense_rnk =N;          

-- Q47: Find employees whose salary is in top 10%
select * 
from (
       select emp_id,
               name,
               salary,
                round(
                 percent_rank() over(order by salary),4) as salary_percentaile
                   from employees)t
  where salary_percentaile >=0.9
  order by  salary_percentaile desc;

-- Q48: Find consecutive order dates (streak problem)
select *
from (
       select order_id,
               emp_id,
               order_date,
               amount,
              lag(order_date) over(order by order_date) as pre_order_date
               from orders)t
  where datediff(order_date, pre_order_date)=1;           

-- Q49: Find employees with no orders in last 30 days
select *
from employees e
where not exists (
                  select 1
                  from orders o
                  where e.emp_id=o.emp_id
                  and o.order_date >=curdate() - interval 30 day);


-- Q50: Find department with highest average salary
select  round(
        avg(salary),2) as avg_salary,
		department
from employees
group by department
order by avg_salary desc
limit 1;
                
 
 
 
 
 

