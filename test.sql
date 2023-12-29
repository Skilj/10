-- 1. Выбрать всех клиентов, которые сделали заказы в текущем месяце, и отсортировать их по убыванию общей суммы заказов.

SELECT c.*, SUM(o.total_amount) AS total_order_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE EXTRACT(MONTH FROM o.order_date) = EXTRACT(MONTH FROM CURRENT_DATE)
GROUP BY c.customer_id
ORDER BY total_order_amount DESC;

-- 2. Выбрать все продукты, которые имеют цену выше средней по категории, и отсортировать их по возрастанию цены.

SELECT p.*
FROM products p
JOIN (
    SELECT category_id, AVG(price) AS avg_price
    FROM products
    GROUP BY category_id
) avg_prices ON p.category_id = avg_prices.category_id
WHERE p.price > avg_prices.avg_price
ORDER BY p.price ASC;

-- 3. Выбрать все заказы, которые содержат продукты из категории "Электроника", и отсортировать их по дате заказа.

SELECT o.*
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.category = 'Электроника'
ORDER BY o.order_date;

-- 4. Выбрать всех клиентов, которые не сделали ни одного заказа в прошлом году, и отсортировать их по алфавиту.

SELECT c.*
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id AND EXTRACT(YEAR FROM o.order_date) = EXTRACT(YEAR FROM CURRENT_DATE) - 1
WHERE o.order_id IS NULL
ORDER BY c.customer_name;

-- 5. Выбрать все продукты, которые не были заказаны ни разу, и отсортировать их по названию.

SELECT p.*
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
WHERE od.product_id IS NULL
ORDER BY p.product_name;

-- Рекомендации по оптимизации базы данных:

-- 1. Индексы
-- Обеспечьте наличие индексов на колонках, используемых в условиях соединений и WHERE, для оптимизации выполнения запросов.

-- 2. Оптимизация запросов
-- Проверяйте выполнение запросов с использованием инструментов выполнения запросов и оптимизации, таких как EXPLAIN ANALYZE.

-- 3. Бэкапы и восстановление
-- Регулярно выполняйте бэкап базы данных и тестируйте процедуры восстановления.

-- 4. Нормализация данных
-- Убедитесь в нормализованном состоянии базы данных для избежания дублирования данных.

-- 5. Использование транзакций
-- Обеспечьте правильное использование транзакций для предотвращения некорректных данных в случае ошибок выполнения запросов.

-- 6. Мониторинг и оптимизация производительности
-- Регулярно мониторьте производительность базы данных и оптимизируйте при необходимости.

-- 7. Безопасность данных
-- Убедитесь в правильных настройках доступа и шифрования для обеспечения безопасности данных, особенно если в базе содержатся чувствительные данные клиентов.
