from faker import Faker
import random

fake = Faker()

# --- CONFIG ---
NUM_CUSTOMERS = 15      # matches your actual customers table
NUM_PRODUCTS = 10       # matches your actual products table
NUM_ORDERS = 50
STATUSES = ["Pending", "Shipped", "Delivered", "Cancelled"]

output = []

# orders table
for order_id in range(1, NUM_ORDERS + 1):
    customer_id = random.randint(1, NUM_CUSTOMERS)
    order_date = fake.date_between(start_date="-1y", end_date="today")
    status = random.choice(STATUSES)
    output.append(
        f"INSERT INTO orders (order_id, customer_id, order_date, status) VALUES "
        f"({order_id}, {customer_id}, '{order_date}', '{status}');"
    )

output.append("")  # blank line separator

# order_items table
order_item_id = 1
for order_id in range(1, NUM_ORDERS + 1):
    num_items = random.randint(1, 4)  # each order has 1-4 line items
    for _ in range(num_items):
        product_id = random.randint(1, NUM_PRODUCTS)
        quantity = random.randint(1, 5)
        price = round(random.uniform(5, 200), 2)
        output.append(
            f"INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price_at_purchase) VALUES "
            f"({order_item_id}, {order_id}, {product_id}, {quantity}, {price});"
        )
        order_item_id += 1

with open("orders_data.sql", "w") as f:
    f.write("\n".join(output))

print(f"Done. Generated {NUM_ORDERS} orders and {order_item_id - 1} order items.")