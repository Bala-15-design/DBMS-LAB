USE taxation_dbms;
SHOW TABLES;
SELECT t.Full_Name, i.income_source
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id;
SELECT t.Full_Name,
       c.category_name
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id;
SELECT i.income_source,
f.year_label
FROM Income_Record i INNER JOIN Financial_Year f
ON i.year_id = f.year_id;
SELECT t.Full_Name,
       t.Annual_income,
       i.amount
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id;
SELECT t.Full_Name,
       i.income_source,
       c.category_name,
       f.year_label
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
INNER JOIN Financial_Year f
ON i.year_id = f.year_id;
SELECT t.Full_Name,
       i.income_source
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
WHERE c.category_name = 'Salary';
SELECT t.Full_Name,
       t.occupation,
       i.income_source
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
WHERE c.category_name = 'Business';
SELECT t.Full_Name,
       f.start_date,
       f.end_date
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Financial_Year f
ON i.year_id = f.year_id;
SELECT t.Full_Name,
       t.pan_number,
       t.occupation,
       i.income_source,
       c.category_name,
       i.amount,
       f.year_label,
       f.start_date,
       f.end_date
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
INNER JOIN Financial_Year f
ON i.year_id = f.year_id;
