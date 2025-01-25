## Employee-Project-Management-System

## Overview
This project represents a company database system with tables for employees, departments, projects, and employee-project assignments. The goal is to manage and query data regarding employees, their departments, and their involvement in various projects.

## Tables:
1. **Employees**: Stores information about employees, such as ID, name, birth date, gender, department, hire date, and salary.
2. **Departments**: Stores information about departments, such as department ID, name, and manager.
3. **Projects**: Stores details about projects, including project ID, name, start date, end date, and budget.
4. **EmployeeProjects**: This is a junction table linking employees to the projects they work on, along with the number of hours worked on each project.

## Prerequisites:
1. MySQL or another relational database management system (RDBMS)
2. SQL scripts for table creation and data insertion

**Query Insights:** 
  - Retrieve lists of employees based on salary or department.
  - Calculate department-wise average salary.
  - Track total hours worked on projects.
  - Identify top-paid employees.
  - Project management insights based on employee involvement.

## Usage
This project is designed to be used for managing employee and project data in a corporate setting. Use the queries provided in the repository to extract meaningful insights and perform regular database operations.

## Contributions
Contributions are welcome! Feel free to fork this repository, make changes, and submit a pull request.
