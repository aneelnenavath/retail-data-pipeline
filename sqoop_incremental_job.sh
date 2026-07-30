# Incremental Sqoop job (orders table)
# Demonstrates incremental append using a saved Sqoop job, which auto-tracks last-value between runs
sqoop job --create incremental_orders_job -- import --connect jdbc:mysql://localhost/retail_db --username root --password-file file:///home/cloudera/pfile --table orders --target-dir /user/cloudera/retail_db/orders --incremental append --check-column order_id --last-value 52
# To run the job (auto-updates last-value on success): sqoop job --exec incremental_orders_job
