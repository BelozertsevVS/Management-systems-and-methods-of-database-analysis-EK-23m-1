-- Завдання 1
-- Напишіть запит, який поверне список унікальних ідентифікаторів виробників товару (MFR).
-- Враховуйте лише замовлення, які були проведені у 2008 році клієнтами зі словом CORP у назві (COMPANY). Для цього необхідно використовувати оператор LIKE та підстановочні знаки (wildcards).
-- - Використовуються таблиці: dbo.CUSTOMERS, dbo.ORDERS
-- - Застосуйте внутрішнє з'єднання (ANSI-92)
-- - Результуючий набір даних містить: Ідентифікатор виробника товару (без дублікатів)
-- Додаткові (необов’язкові) умови завдання:
-- Необхідно уникнути неявних перетворень типів даних, тобто зверніть увагу на
-- типи даних стовпців, які задіяні для фільтрації рядків. Виключіть обчислювані
-- вирази в умовах пошуку.


SELECT DISTINCT [REP]
FROM [dbo].[ORDERS]
JOIN [dbo].[CUSTOMERS] ON [CUST] = [dbo].[CUSTOMERS].[CUST_NUM]
WHERE
  [ORDER_DATE] BETWEEN '20080101' AND '20081231' AND
  UPPER([dbo].[CUSTOMERS].[COMPANY]) LIKE '%CORP%';


-- Завдання 2
-- Напишіть запит, який у розрізі ідентифікатора клієнта (CUST_NUM) та місяця проведення замовлення (ORDER_DATE) поверне кількість унікальних замовлень (для цього використовується GROUP BY). Враховуйте лише замовлення, які були проведені у 2008 році клієнтами зі словом CORP. у назві (COMPANY). У випадку, якщо у клієнта не було жодного замовлення, залиште такого клієнта у результуючому наборі даних.
-- Відсортуйте результативний набір даних за кількістю проведених замовлень (за спаданням)
-- - Використовуються таблиці: dbo.CUSTOMERS, dbo.ORDERS
-- - Застосуйте ліве зовнішнє з'єднання
-- - Результуючий набір даних містить: ідентифікатор клієнта, місяць проведення замовлення (для отримання місяця з дати замовлення використовуємо функцію MONTH), кількість унікальних замовлень (використовуємо COUNT)
-- Додаткові (необов’язкові) умови завдання:
-- Постарайтеся уникнути неявних перетворень типів даних, тобто зверніть увагу на типи даних стовпців, які задіяні для фільтрації рядків. Виключіть обчислювані вирази в умовах пошуку.

SELECT
  [CUST_NUM],
  MONTH([dbo].[ORDERS].[ORDER_DATE]) AS MONTH,
  COUNT([dbo].[ORDERS].[ORDER_NUM]) AS COUNT
FROM [dbo].[CUSTOMERS]
LEFT OUTER JOIN [dbo].[ORDERS] ON [CUST_NUM] = [dbo].[ORDERS].[CUST]
WHERE
  UPPER([COMPANY]) LIKE '%CORP%' AND (
    [dbo].[ORDERS].[ORDER_DATE] IS NULL OR
    [dbo].[ORDERS].[ORDER_DATE] BETWEEN '20080101' AND '20081231'
  )
GROUP BY [CUST_NUM], MONTH([dbo].[ORDERS].[ORDER_DATE])
ORDER BY COUNT([dbo].[ORDERS].[ORDER_NUM]) DESC;


-- Завдання 3
-- Напишіть запит, який поверне список (без дублікатів) придбаних товарів.
-- Враховуйте лише замовлення, які були проведені у 2008 році клієнтами зі словом CORP у назві (COMPANY). У випадку, якщо у клієнта не було жодного замовлення, залиште такого клієнта у результуючому наборі даних.
-- - Використовуються таблиці: dbo.CUSTOMERS, dbo.ORDERS, dbo.PRODUCTS
-- - Застосуйте ліве зовнішнє з'єднання
-- - Результуючий набір даних містить: Ідентифікатор клієнта, назва компанії (у верхньому регістрі. Для цього використовуємо рядкову функцію (String Function) UPPER), опис товару ([DESCRIPTION])
-- Додаткові (необов’язкові) умови завдання:
-- Постарайтеся уникнути неявних перетворень типів даних, тобто зверніть увагу на типи даних стовпців, які задіяні для фільтрації рядків. Виключіть обчислювані вирази в умовах пошуку.


SELECT DISTINCT
  [CUST_NUM],
  UPPER([COMPANY]),
  [dbo].[PRODUCTS].[DESCRIPTION]
FROM [dbo].[CUSTOMERS]
LEFT OUTER JOIN [dbo].[ORDERS] ON [CUST_NUM] = [dbo].[ORDERS].[CUST]
LEFT OUTER JOIN [dbo].[PRODUCTS] ON
  [dbo].[ORDERS].[MFR] = [dbo].[PRODUCTS].[MFR_ID] AND
  [dbo].[ORDERS].[PRODUCT] = [dbo].[PRODUCTS].[PRODUCT_ID]
WHERE
  UPPER([COMPANY]) LIKE '%CORP%' AND (
    [dbo].[ORDERS].[ORDER_DATE] IS NULL OR
    [dbo].[ORDERS].[ORDER_DATE] BETWEEN '20080101' AND '20081231'
  );