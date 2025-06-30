create database Employee_Management_System ;

use Employee_Management_System ;


-- Table 1: Job Department
CREATE TABLE JobDepartment (
    Job_ID INT PRIMARY KEY,
    jobdept VARCHAR(50),
    name VARCHAR(100),
    description TEXT,
    salaryrange VARCHAR(50)
);
-- Table 2: Salary/Bonus
CREATE TABLE SalaryBonus (
    salary_ID INT PRIMARY KEY,
    Job_ID INT,
    amount DECIMAL(10,2),
    annual DECIMAL(10,2),
    bonus DECIMAL(10,2),
    CONSTRAINT fk_salary_job FOREIGN KEY (job_ID) 
    REFERENCES JobDepartment(Job_ID)
	ON DELETE CASCADE ON UPDATE CASCADE
);
-- Table 3: Employee
CREATE TABLE Employee (
    emp_ID INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    contact_add VARCHAR(100),
    emp_email VARCHAR(100) UNIQUE,
    emp_pass VARCHAR(50),
    Job_ID INT,
    CONSTRAINT fk_employee_job FOREIGN KEY (Job_ID)
     REFERENCES JobDepartment(Job_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Table 4: Qualification
CREATE TABLE Qualification (
    QualID INT PRIMARY KEY,
    Emp_ID INT,
    Position VARCHAR(50),
    Requirements VARCHAR(255),
    Date_In DATE,
    CONSTRAINT fk_qualification_emp FOREIGN KEY (Emp_ID)
        REFERENCES Employee(emp_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Table 5: Leaves
CREATE TABLE Leaves (
    leave_ID INT PRIMARY KEY,
    emp_ID INT,
    date DATE,
    reason TEXT,
    CONSTRAINT fk_leave_emp FOREIGN KEY (emp_ID) REFERENCES Employee(emp_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table 6: Payroll
CREATE TABLE Payroll (
    payroll_ID INT PRIMARY KEY,
    emp_ID INT,
    job_ID INT,
    salary_ID INT,
    leave_ID INT,
    date DATE,
    report TEXT,
    total_amount DECIMAL(10,2),
    CONSTRAINT fk_payroll_emp FOREIGN KEY (emp_ID) REFERENCES Employee(emp_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_job FOREIGN KEY (job_ID) REFERENCES JobDepartment(job_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_salary FOREIGN KEY (salary_ID) REFERENCES SalaryBonus(salary_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_leave FOREIGN KEY (leave_ID) REFERENCES Leaves(leave_ID)
        ON DELETE SET NULL ON UPDATE CASCADE
);

select * from employee;
select * from jobdepartment;
select * from leaves;
select *  from payroll;
select * from qualification ;
select * from salarybonus; 


-- Analysis Questions
-- 1. EMPLOYEE INSIGHTS

-- Q1. How many unique employees are currently in the system?

select count(distinct emp_id) as total_unique from employee;

-- Q2 Which departments have the highest number of employees?

select jd.jobdept, count(e.emp_id) as employee_count
from  employee e
inner join jobdepartment jd on e.job_id = jd.job_id
group by jd.jobdept
order by employee_count desc
limit 1;

-- Q3 What is the average salary per department?
select * from salarybonus;
select * from jobdepartment;

select jd.jobdept , avg(sb.annual) as average_salary from salarybonus sb
inner join jobdepartment jd on sb.job_id = jd.job_id 
group by jd.jobdept;

-- Q4.Who are the top 5 highest-paid employees?
select *from employee;
select * from salarybonus;
 
 select concat( e.firstname,' ' , e.lastname) as full_name , sb.annual from salarybonus sb
 inner join employee e  on sb.job_id = e.job_id
 order by sb.annual desc
 limit 5;

-- Q5 What is the total salary expenditure across the company?
select * from salarybonus;
select sum( annual + bonus) as total_salary_expenditure from salarybonus;


-- 2. JOB ROLE AND DEPARTMENT ANALYSIS

--  Q1 How many different job roles exist in each department?
select * from jobdepartment;

select jobdept, count(distinct name ) as job_roels from jobdepartment
group by jobdept;

-- Q2 What is the average salary range per department?
select * from jobdepartment;

select jobdept, 
    avg(replace(SUBSTRING_INDEX(replace(salaryrange, '$', ''), '-', 1), ',', '') ) as min_range, 
    avg(replace(SUBSTRING_INDEX(replace(salaryrange, '$', ''), '-', -1), ',', '') ) as max_range
from jobdepartment
group by jobdept ;

-- Q3.Which job roles offer the highest salary?
select * from jobdepartment;
select * from salarybonus;

select jd.job_id, jd.name ,sb.annual as higest_salary from jobdepartment jd
inner join salarybonus sb on jd.job_id = sb.job_id
order by sb.annual desc
limit 5;

-- Q4.Which departments have the highest total salary allocation?

select  jd.jobdept ,sum(sb.annual +sb.bonus) as higest_total_salary from jobdepartment jd
inner join salarybonus sb on jd.job_id = sb.job_id
group by jd.jobdept
order by higest_total_salary desc
limit 5;


-- 3. QUALIFICATION AND SKILLS ANALYSIS

-- Q1.How many employees have at least one qualification listed?
select * from employee;
select * from  qualification;

select count( distinct emp_id) as qualification_listed from qualification;

-- Q2.Which positions require the most qualifications?
select * from  qualification;

select position , count(*) as number_qualification
from qualification
group by position 
order by number_qualification desc;

-- Q3.Which employees have the highest number of qualifications?
select * from  qualification;
select * from employee;
select * from jobdepartment;

select e.emp_id,concat(firstname," ",lastname),q.Position,count(position) from employee e inner join qualification q on e.emp_id=q.emp_id
group by e.emp_id,concat(firstname," ",lastname),q.Position;


-- ---------------------------------------------------------------------------------------

-- 4. LEAVE AND ABSENCE PATTERNS

-- Q1.Which year had the most employees taking leaves?
select* from leaves;

select year(date) , count(distinct emp_id) as employ_count from leaves
group by year(date)
order by employ_count desc;

select  Year(Leaves.date) as leaveYear,count(distinct Leaves.emp_ID) as Employees_onLeave
from Leaves
group by Year(Leaves.date)
order by Employees_onLeave desc
limit 1;

-- Q2.What is the average number of leave days taken by its employees per department?
select * from leaves;
select * from employee;
select * from payroll;
select JobDepartment.jobdept, avg(leave_counts.leave_days) as avg_leave_days_per_employee
from (
    select Leaves.emp_ID, count ()  as leave_days from Leaves
    group by Leaves.emp_ID
) as leave_counts
join Employee on leave_counts.emp_ID = Employee.emp_ID
join JobDepartment on Employee.Job_ID = JobDepartment.Job_ID
group by JobDepartment.jobdept;



-- Q3.Which employees have taken the most leaves?

select e.emp_ID,e.firstname,e.lastname, count(leaves.leave_ID) as Total_LeaveDays
from employee e
inner join leaves  on e.emp_ID = leaves.emp_ID
group by e.emp_ID,e.firstname,e.lastname
order by Total_LeaveDays desc
limit 5;



-- Q4.What is the total number of leave days taken company-wide?
select count(*) as  leave_Days
from Leaves;


-- Qq.How do leave days correlate with payroll amounts?
select 
    e.emp_ID, 
    e.firstname, 
    e.lastname, 
    count(Leaves.leave_ID) as total_leave_days, 
    SUM(Payroll.total_amount) as total_payroll
from Employee e
left join Leaves ON e.emp_ID = Leaves.emp_ID
left join Payroll ON e.emp_ID = Payroll.emp_ID
group by e.emp_ID, e.firstname, e.lastname
order by total_leave_days desc;
-- --------------------------------------------------------------------------------------------------------

-- 5. PAYROLL AND COMPENSATION ANALYSIS

-- What is the total monthly payroll processed?
select * from payroll;

select sum(total_amount) as total_monthly_payroll_processed 
from payroll;



-- Q2.What is the average bonus given per department?

select * from jobdepartment;
select * from salarybonus;

select jd.jobdept , avg(sb.bonus) as average_bonus from salarybonus sb
inner join jobdepartment jd on sb.job_id = jd.job_id
group by jd.jobdept;

-- Q3.Which department receives the highest total bonuses?
select * from jobdepartment;
select * from salarybonus;
select jd.jobdept , sum(sb.bonus) as total_bonus from salarybonus sb
inner join jobdepartment jd on sb.job_id = jd.job_id
group by jd.jobdept
order by total_bonus
limit 1 ;

-- Q4.What is the average value of total_amount after considering leave deductions?
select * from payroll;
select * from leaves;
select avg(total_amount) as avg_value_amount from payroll;



-- 6. EMPLOYEE PERFORMANCE AND GROWTH
-- Q1.Which year had the highest number of employee promotions?
select * from qualification;
select * from salarybonus;
select * from payroll;
select year(date_in) as promotion_year ,count(*) as n_p
from qualification
group by promotion_year
order by n_p desc
limit 1;

