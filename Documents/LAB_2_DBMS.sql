USE taxation_dbms;
ALTER TABLE Income_Record
DROP COLUMN category_name,
DROP COLUMN financial_year;
ALTER TABLE Income_Record
ADD category_id INT,
ADD year_id INT;
ALTER TABLE Income_Record
ADD CONSTRAINT fk_taxpayer
FOREIGN KEY (taxpayer_id)
REFERENCES Taxpayer(taxpayer_id);
ALTER TABLE Income_Record
ADD CONSTRAINT fk_category
FOREIGN KEY (category_id)
REFERENCES Income_Category(category_id);
ALTER TABLE Income_Record
ADD CONSTRAINT fk_year
FOREIGN KEY (year_id)
REFERENCES Financial_Year(year_id);
DESCRIBE Income_Record;
UPDATE Income_Record
SET category_id = 1, year_id = 6
WHERE income_id IN (1001,1002,1004);
UPDATE Income_Record
SET category_id = 2, year_id = 6
WHERE income_id IN (1003,1005,1006);
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1007, 999, 'ABC Company', 500000.00, '2026-03-31', 'Test Record', 1, 6);
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1008, 101, 'ABC Company', 500000.00, '2026-03-31', 'Test Record', 20, 6);
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1009, 101, 'ABC Company', 500000.00, '2026-03-31', 'Test Record', 1, 15);
DELETE FROM Taxpayer
WHERE taxpayer_id = 101;
DELETE FROM Income_Category
WHERE category_id = 1;
SELECT DISTINCT occupation FROM taxpayer;
SELECT DISTINCT category_name FROM Income_Category;
SELECT DISTINCT year_label FROM Financial_Year;
SELECT DISTINCT income_source FROM Income_Record;
SELECT full_name FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 1
) 
UNION 
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 2
);
SELECT income_source FROM Income_Record
WHERE year_id = 5
UNION
SELECT income_source FROM Income_Record
WHERE year_id = 6;
SELECT full_name FROM Taxpayer
WHERE occupation = 'Teacher'
UNION
SELECT full_name FROM Taxpayer
WHERE occupation = 'Software Engineer';
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 1
)
AND taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 2
);
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE year_id = 5
)
AND taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE year_id = 6
);
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 1
)
AND taxpayer_id NOT IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = 2
);
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE year_id = 6
)
AND taxpayer_id NOT IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE year_id = 5
);
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
);
SELECT *
FROM Taxpayer
WHERE occupation IN (
    SELECT occupation
    FROM Taxpayer
    WHERE taxpayer_id IN (
SELECT taxpayer_id
FROM Income_Record
WHERE category_id = 2
    )
);
SELECT full_name
FROM Taxpayer
WHERE taxpayer_id NOT IN (
SELECT taxpayer_id
FROM Income_Record
);
SELECT DISTINCT occupation
FROM Taxpayer
WHERE occupation NOT IN (
    SELECT DISTINCT T.occupation
    FROM Taxpayer T
    JOIN Income_Record I
    ON T.taxpayer_id = I.taxpayer_id
);
SELECT full_name
FROM Taxpayer T
WHERE EXISTS (
    SELECT *
    FROM Income_Record I
    WHERE I.taxpayer_id = T.taxpayer_id
);
SELECT year_label
FROM Financial_Year F
WHERE EXISTS (
    SELECT *
    FROM Income_Record I
    WHERE I.year_id = F.year_id
);
SELECT full_name
FROM Taxpayer T
WHERE NOT EXISTS (
    SELECT *
    FROM Income_Record I
    WHERE I.taxpayer_id = T.taxpayer_id
);
SELECT category_name
FROM Income_Category C
WHERE NOT EXISTS (
    SELECT *
    FROM Income_Record I
    WHERE I.category_id = C.category_id
);
SELECT *
FROM Taxpayer
WHERE annual_income > ANY (
    SELECT annual_income
    FROM Taxpayer
    WHERE occupation = 'Teacher'
);
SELECT *
FROM Taxpayer
WHERE annual_income > ANY (
    SELECT amount
    FROM Income_Record
    WHERE category_id = 2
);
SELECT *
FROM Taxpayer
WHERE annual_income > ALL (
    SELECT annual_income
    FROM Taxpayer
    WHERE occupation = 'Teacher'
);
SELECT *
FROM Taxpayer
WHERE annual_income > ALL (
    SELECT amount
    FROM Income_Record
    WHERE category_id = 2
);
SELECT * FROM Taxpayer
ORDER BY full_name ASC;
SELECT * FROM Taxpayer
WHERE annual_income > 800000;
SELECT * FROM Taxpayer
WHERE occupation = 'Software Engineer';
SELECT * FROM Income_Record
WHERE category_id = 2;
SELECT * FROM Income_Record
WHERE amount BETWEEN 500000 AND 1000000;
SELECT * FROM Taxpayer
WHERE full_name LIKE 'A%';
SELECT * FROM Taxpayer
WHERE is_active = TRUE;
SELECT COUNT(*) AS Total_Taxpayers
FROM Taxpayer;
SELECT MAX(annual_income) AS Highest_Annual_Income FROM Taxpayer;
SELECT *
FROM Taxpayer
WHERE annual_income = (
    SELECT MAX(annual_income)
    FROM Taxpayer
);
SELECT category_id, COUNT(*) AS Total_Records
FROM Income_Record
GROUP BY category_id
ORDER BY Total_Records DESC
LIMIT 1;
SELECT occupation, COUNT(*) AS Total_Taxpayers
FROM Taxpayer
GROUP BY occupation;
SELECT COUNT(*) AS Active_Taxpayers
FROM Taxpayer
WHERE is_active = TRUE;
SELECT year_id, COUNT(*) AS Total_Records
FROM Income_Record
GROUP BY year_id
ORDER BY Total_Records DESC
LIMIT 1;