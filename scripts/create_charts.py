import csv
import matplotlib.pyplot as plt

months = []
revenue = []

with open("results/monthly_revenue.csv", newline="") as file:
    reader = csv.DictReader(file)

    for row in reader:
        months.append(row["sales_month"])
        revenue.append(float(row["monthly_revenue"]))

plt.figure(figsize=(10, 6))
plt.plot(months, revenue, marker="o")

plt.title("Monthly Completed-Order Revenue")
plt.xlabel("Month")
plt.ylabel("Revenue ($)")
plt.xticks(rotation=45)
plt.tight_layout()

plt.savefig("results/charts/monthly_revenue.png", dpi=300)
plt.close()

# Product revenue chart

products = []
product_revenue = []

with open("results/product_performance.csv", newline="") as file:
    reader = csv.DictReader(file)

    for row in reader:
        products.append(row["product_name"])
        product_revenue.append(float(row["total_revenue"]))

plt.figure(figsize=(10, 7))
plt.barh(products, product_revenue)

plt.title("Revenue by Product")
plt.xlabel("Revenue ($)")
plt.ylabel("Product")
plt.tight_layout()

plt.savefig("results/charts/product_revenue.png", dpi=300)
plt.close()

# Customer revenue chart

customers = []
customer_revenue = []

with open("results/customer_revenue.csv", newline="") as file:
    reader = csv.DictReader(file)

    for row in reader:
        customers.append(row["customer_name"])
        customer_revenue.append(float(row["total_revenue"]))

plt.figure(figsize=(10, 7))
plt.barh(customers, customer_revenue)

plt.title("Revenue by Customer")
plt.xlabel("Revenue ($)")
plt.ylabel("Customer")
plt.tight_layout()

plt.savefig("results/charts/customer_revenue.png", dpi=300)
plt.close()