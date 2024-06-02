-- Напишите запросы, которые выводят следующую информацию:
-- 1. заказы, отправленные в города, заканчивающиеся на 'burg'. Вывести без повторений две колонки (город, страна) (см. таблица orders, колонки ship_city, ship_country)
select DISTINCT ship_city, ship_country
from  orders
WHERE ship_city like '%burg'
GROUP BY ship_city, ship_country 
-- 2. из таблицы orders идентификатор заказа, идентификатор заказчика, вес и страну отгрузки. Заказ отгружен в страны, начинающиеся на 'P'. Результат отсортирован по весу (по убыванию). Вывести первые 10 записей.
select order_id, customer_id, freight, ship_country
from  orders
WHERE ship_country like 'P%'
GROUP BY order_id
ORDER BY freight DESC
LIMIT 10
-- 3. имя, фамилию и телефон сотрудников, у которых в данных отсутствует регион (см таблицу employees)
select first_name, last_name, home_phone
from employees
WHERE region IS NULL
GROUP BY first_name, last_name, home_phone
ORDER BY first_name DESC
-- 4. количество поставщиков (suppliers) в каждой из стран. Результат отсортировать по убыванию количества поставщиков в стране
select country, COUNT(*)
from suppliers
GROUP BY country
ORDER BY COUNT(*) DESC
-- 5. суммарный вес заказов (в которых известен регион) по странам, но вывести только те результаты, где суммарный вес на страну больше 2750. Отсортировать по убыванию суммарного веса (см таблицу orders, колонки ship_region, ship_country, freight)
select DISTINCT ship_country, SUM(freight)
from orders
WHERE ship_region IS NOT NULL
GROUP BY ship_country
HAVING SUM(freight) > 2750
ORDER BY SUM(freight) DESC
-- 6. страны, в которых зарегистрированы и заказчики (customers) и поставщики (suppliers) и работники (employees).
select country
from customers
INTERSECT
select country
from suppliers
INTERSECT
select country
from employees
-- 7. страны, в которых зарегистрированы и заказчики (customers) и поставщики (suppliers), но не зарегистрированы работники (employees).
select country
from customers
INTERSECT
select country
from suppliers
EXCEPT
select country
from employees
