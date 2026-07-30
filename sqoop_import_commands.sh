#!/bin/bash
# Sqoop import commands: MySQL retail_db -> HDFS
# 1. Customers
sqoop import --connect jdbc:mysql://localhost/retail_db --username root --password-file file:///home/cloudera/pfile --table customers --target-dir /user/cloudera/retail_db/customers --m 1
# 2. Products
sqoop import --connect jdbc:mysql://localhost/retail_db --username root --password-file file:///home/cloudera/pfile --table products --target-dir /user/cloudera/retail_db/products --m 1
# 3. Orders
sqoop import --connect jdbc:mysql://localhost/retail_db --username root --password-file file:///home/cloudera/pfile --table orders --target-dir /user/cloudera/retail_db/orders --m 1
# 4. Order Items (parallel, 4 mappers)
sqoop import --connect jdbc:mysql://localhost/retail_db --username root --password-file file:///home/cloudera/pfile --table order_items --target-dir /user/cloudera/retail_db/order_items --m 4
