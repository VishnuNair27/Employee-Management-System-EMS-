# 📊 Employee Management System Database

A structured relational database project designed to manage and analyze employee details, job roles, compensation, leaves, and qualifications within an organization. Developed using **MySQL**, it showcases deep analysis through optimized queries and robust schema design.

## 🛠️ Technologies Used

- **Database:** MySQL  
- **Language:** SQL  
- **Key Concepts:** ER modeling, Foreign Keys, Joins, Aggregation, Subqueries, Data Analysis

---

## 🗂️ Database Structure

The project includes six interconnected tables:

| Table Name      | Purpose                                                       |
|------------------|---------------------------------------------------------------|
| `JobDepartment`  | Stores job roles and salary range details                     |
| `SalaryBonus`    | Records salary, bonus, and compensation related to jobs       |
| `Employee`       | Contains employee personal information and job assignment     |
| `Qualification`  | Tracks qualifications and promotions of employees             |
| `Leaves`         | Logs employee leaves and reasons                              |
| `Payroll`        | Captures final payroll reports including salary, leaves, etc. |

---

## 📌 Core Features

### 🔧 Database Creation & Schema Design
- Defined **foreign key constraints** for referential integrity  
- Enabled **cascading updates and deletions** for dependent entities  
- Included meaningful column types and validations (e.g. `UNIQUE`, `NOT NULL`)

### 📈 Analysis Queries

#### 1. 👥 Employee Insights
- Total unique employees
- Department-wise employee distribution
- Top 5 highest-paid employees
- Average salary per department

#### 2. 🧩 Job Roles & Departments
- Count of roles per department
- Average salary range (parsed from string)
- Highest paying jobs and departments

#### 3. 🎓 Qualifications
- Number of employees with qualifications
- Most demanded positions (by qualifications)
- Top employees by qualification count

#### 4. 🛌 Leave Patterns
- Year with highest leave records
- Employees with most leaves
- Department-wise leave averages

#### 5. 💸 Payroll & Compensation
- Monthly payroll totals
- Average bonus per department
- Department with highest bonus allocation

#### 6. 📊 Performance Growth
- Year with most promotions (via qualification timestamp)

---

## ⚙️ Sample Query Example

```sql
-- Total unique employees
SELECT COUNT(DISTINCT emp_id) AS total_unique FROM Employee;
```

---

## 🚀 How to Run

1. Use MySQL Workbench or any compatible SQL interface  
2. Run the schema creation scripts  
3. Insert sample/mock data if required  
4. Execute queries for insights

---

## 🎯 Use Cases

- HR Analytics Platforms  
- Employee Lifecycle & Compensation Analysis  
- Internal Organization Dashboards  
- Power BI Dashboard Integration for Visualization  

---

## ✨ Showcase Potential

This schema pairs beautifully with Power BI or Tableau to create stunning visual dashboards — imagine interactive KPI cards, department filters, and payroll heatmaps that make your analytics cinematic and immersive.

---

Let me know if you'd like me to help mock up a Power BI dashboard structure for this, or add example data inserts too. I think your storytelling flair would shine with dynamic visuals layered on top of this robust backend!

