# Retail Sales SQL Analysis

## Project Overview

This project analyzes sales data for a fictional online retailer using SQLite and SQL. The dataset includes customers, products, orders, and order items.

The goal of the project is to use relational data and SQL queries to answer practical business questions related to sales performance, customers, products, order activity, and purchasing trends.

## Tools Used

- SQLite
- SQL
- VS Code
- Git & GitHub

## Database Structure

The database contains four related tables:

- `customers` — customer information and signup dates
- `products` — product names, categories, and prices
- `orders` — order dates, customers, and order status
- `order_items` — products, quantities, and transaction prices

The tables are connected using primary and foreign keys to represent relationships between customers, orders, and products.

## Analysis

The SQL analysis examines:

- Total completed-order revenue
- Revenue by product and category
- Units sold by product
- Average order value
- Monthly sales trends
- Customer purchasing activity
- Repeat customers
- Customer revenue
- Order status and cancellations
- Revenue associated with cancelled orders
- Revenue by customer state
- Product and category performance
- Customer revenue rankings

## Key Findings

The analysis identified several notable patterns within the dataset:

- Completed orders generated **$5,514.20** in revenue.
- The average completed order value was **$177.88**.
- The **Ergonomic Desk Chair** generated the most product revenue at **$1,249.95**.
- **HDMI Cable** had the highest unit volume with **10 units sold**.
- **Electronics** generated the most category revenue at **$1,919.81**.
- **June 2026** had the highest monthly revenue at **$839.89**.
- **Texas** generated the most completed-order revenue at **$1,404.78**.
- There were **31 completed orders** and **3 cancelled orders**.
- The three cancelled orders represented **$789.94** in associated order value.

## SQL Skills Demonstrated

This project demonstrates practical use of:

- `SELECT`
- `WHERE`
- `JOIN`
- `LEFT JOIN`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- Aggregate functions
- Calculated fields
- Subqueries
- Date functions
- `COUNT(DISTINCT ...)`
- Window functions and `RANK()`

## Visualizations

The project includes three visualizations generated from the SQL analysis results:

- **Monthly Revenue** — shows completed-order revenue across the nine-month dataset.
- **Revenue by Product** — compares completed-order revenue across individual products.
- **Revenue by Customer** — compares total completed-order revenue across customers.

The charts are generated with Python and Matplotlib using the CSV files exported from the SQL analysis.

## Repository Structure

```text
retail-sales-sql-analysis/
├── data/
│   ├── customers.csv
│   ├── products.csv
│   ├── orders.csv
│   └── order_items.csv
├── results/
│   ├── charts/
│   │   ├── monthly_revenue.png
│   │   ├── product_revenue.png
│   │   └── customer_revenue.png
│   ├── customer_revenue.csv
│   ├── monthly_revenue.csv
│   └── product_performance.csv
├── scripts/
│   └── create_charts.py
├── sql/
│   ├── analysis_queries.sql
│   └── create_tables.sql
├── .gitignore
└── README.md

## Purpose

This project was created as a portfolio demonstration of SQL, relational database concepts, data analysis, and the ability to translate raw business data into useful findings.