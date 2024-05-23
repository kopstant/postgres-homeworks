# Скрипт для заполнения данными таблиц в БД Postgres


import csv
import psycopg2

# connect to db
conn = psycopg2.connect(host='localhost', database='north', user='postgres', password='b20d5fcd')
cur = conn.cursor()
with open("north_data/employees_data.csv", 'r') as f:
    reader = csv.reader(f)
    next(reader)

    for row in reader:
        cur.execute("INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)", row)


with open("north_data/customers_data.csv", 'r') as f:
    reader = csv.reader(f)
    next(reader)

    for row in reader:
        cur.execute("INSERT INTO customers VALUES (%s, %s, %s)", row)


with open("north_data/orders_data.csv", 'r') as f:
    reader = csv.reader(f)
    next(reader)

    for row in reader:
        cur.execute("INSERT INTO orders VALUES (%s, %s, %s, %s, %s)", row)
conn.commit()
conn.close()
