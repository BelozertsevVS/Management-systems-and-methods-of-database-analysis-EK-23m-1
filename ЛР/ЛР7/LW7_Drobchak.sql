USE WebStor;

/*
Завдання 1 

Напишіть запит, який поверне список унікальних ідентифікаторів виробників товару (MFR). 
Враховуйте лише замовлення, які були проведені у 2008 році клієнтами зі словом CORP у назві (COMPANY). Для цього необхідно використовувати оператор LIKE та підстановочні знаки (wildcards). 
- Використовуються таблиці: dbo.CUSTOMERS, dbo.ORDERS 
- Застосуйте внутрішнє з'єднання (ANSI-92) 
- Результуючий набір даних містить: Ідентифікатор виробника товару (без дублікатів) 
*/

SELECT DISTINCT MFR
FROM ORDERS
INNER JOIN CUSTOMERS ON ORDERS.CUST = CUSTOMERS.CUST_NUM
WHERE YEAR(ORDERS.ORDER_DATE) = 2008 AND CUSTOMERS.COMPANY LIKE '%Corp%';

/*
Завдання 2

Напишіть запит, який у розрізі ідентифікатора клієнта (CUST_NUM) та місяця проведення замовлення (ORDER_DATE) поверне кількість унікальних замовлень (для цього використовується GROUP BY). 
Враховуйте лише замовлення, які були проведені у 2008 році клієнтами зі словом CORP. у назві (COMPANY). У випадку, якщо у клієнта не було жодного замовлення, залиште такого клієнта у результуючому наборі даних. 
Відсортуйте результативний набір даних за кількістю проведених замовлень (за спаданням) 
- Використовуються таблиці: dbo.CUSTOMERS, dbo.ORDERS 
- Застосуйте ліве зовнішнє з'єднання 
- Результуючий набір даних містить: ідентифікатор клієнта, місяць проведення замовлення (для отримання місяця з дати замовлення використовуємо функцію MONTH), кількість унікальних замовлень (використовуємо COUNT) 
*/

SELECT CUST_NUM, MONTH(ORDER_DATE) AS OrderMonth, COUNT(DISTINCT ORDERS.ORDER_NUM) AS UniqueOrders
FROM CUSTOMERS
LEFT OUTER JOIN ORDERS ON ORDERS.CUST = CUSTOMERS.CUST_NUM
WHERE YEAR(ORDERS.ORDER_DATE) = 2008 AND CUSTOMERS.COMPANY LIKE '%Corp%'
GROUP BY CUSTOMERS.CUST_NUM, MONTH(ORDER_DATE)
ORDER BY UniqueOrders DESC;


/*
Завдання 3

Напишіть запит, який поверне список (без дублікатів) придбаних товарів.  
Враховуйте лише замовлення, які були проведені у 2008 році клієнтами зі словом CORP у назві (COMPANY). У випадку, якщо у клієнта не було жодного замовлення, залиште такого клієнта у результуючому наборі даних. 
- Використовуються таблиці: dbo.CUSTOMERS, dbo.ORDERS, dbo.PRODUCTS 
- Застосуйте ліве зовнішнє з'єднання 
- Результуючий набір даних містить: Ідентифікатор клієнта, назва компанії (у верхньому регістрі. Для цього використовуємо рядкову функцію (String Function) UPPER), опис товару ([DESCRIPTION]) 
*/

SELECT DISTINCT CUST_NUM, UPPER(COMPANY) AS CompanyName, PRODUCTS.DESCRIPTION
FROM CUSTOMERS
LEFT OUTER JOIN ORDERS ON ORDERS.CUST = CUSTOMERS.CUST_NUM
LEFT OUTER JOIN PRODUCTS ON PRODUCTS.MFR_ID = ORDERS.MFR
WHERE YEAR(ORDERS.ORDER_DATE) = 2008 AND CUSTOMERS.COMPANY LIKE '%Corp%';
