-- Check out the Complete Data
SELECT * 
FROM layoffs;


-- Make a Duplicate Table ( To Preserve the Original Table)

CREATE TABLE my_layoffs
LIKE layoffs;

INSERT INTO my_layoffs
SELECT *
FROM layoffs;

SELECT *
FROM my_layoffs;


-- 1. Remove Duplicates

CREATE TABLE `my_layoffs2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO my_layoffs2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM my_layoffs;

SELECT * 
FROM my_layoffs2;

DELETE
FROM my_layoffs2
WHERE row_num > 1;

SELECT *
FROM my_layoffs2
WHERE row_num > 1;


-- 2. Standardizing Data

-- Company Column 

SELECT DISTINCT company
FROM my_layoffs2;


-- Remove Leading Spaces

UPDATE my_layoffs2
SET company = TRIM(company);

SELECT DISTINCT company
FROM my_layoffs2;

-- Industry Column

 SELECT DISTINCT industry
 FROM my_layoffs2
 ORDER BY industry;
 
 SELECT *
 FROM my_layoffs2
 WHERE industry LIKE 'Crypto%';

-- Standardize Crypto
 
 UPDATE my_layoffs2
 SET industry = 'Crypto'
 WHERE industry LIKE 'Crypto%';

 SELECT DISTINCT industry
 FROM my_layoffs2
 ORDER BY industry;

-- Country Column

SELECT DISTINCT country
FROM my_layoffs2
ORDER BY country;

-- Standardized the United States

UPDATE my_layoffs2
-- SET country = TRIM(TRAILING '.' FROM country)
SET country = 'United States'
WHERE country LIKE 'United States%';

SELECT DISTINCT country
FROM my_layoffs2
ORDER BY country;


-- Change Text to Date 

UPDATE my_layoffs2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

ALTER TABLE my_layoffs2
MODIFY COLUMN `date` DATE;


-- 3. Update Null or Blank Values

SELECT *
FROM my_layoffs2
WHERE industry IS NULL
OR industry =''
ORDER BY industry;

-- First Set Empty Industry to NULL

UPDATE my_layoffs2
SET industry = NULL 
WHERE industry = '';

-- Update NULL to Desired Industry

UPDATE my_layoffs2 AS t1
JOIN my_layoffs2 AS t2
ON t1.company =  t2.company 
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

SELECT *
FROM my_layoffs2
WHERE industry IS NULL
ORDER BY industry;


-- 4. Remove Any Row or Columns

-- Remove Null Rows

SELECT * 
FROM my_layoffs2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE 
FROM my_layoffs2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM my_layoffs2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Remove Unnecessary Columns

ALTER TABLE my_layoffs2
DROP COLUMN row_num;

-- Final Table After Cleaning Data
SELECT * 
FROM my_layoffs2;