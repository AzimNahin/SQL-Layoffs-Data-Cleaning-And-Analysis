-- EDA (Exploratory Data Analysis

-- Preview the Table

SELECT *
FROM my_layoffs2;


-- Maximum Laid Off

SELECT * 
FROM my_layoffs2
WHERE total_laid_off = (SELECT MAX(total_laid_off)
						FROM my_layoffs2)
ORDER BY company;

-- Minimum Laid Off

SELECT * 
FROM my_layoffs2
WHERE total_laid_off = (SELECT MIN(total_laid_off)
						FROM my_layoffs2)   
ORDER BY company;

-- Maximum Percentage Laid Off

SELECT * 
FROM my_layoffs2
WHERE percentage_laid_off = (SELECT MAX(percentage_laid_off)
						FROM my_layoffs2)
-- ORDER BY total_laid_off DESC;
ORDER BY funds_raised_millions DESC;

-- Minimum Percentage Laid Off

SELECT * 
FROM my_layoffs2
WHERE percentage_laid_off = (SELECT MIN(percentage_laid_off)
						FROM my_layoffs2)
ORDER BY total_laid_off DESC;
-- ORDER BY funds_raised_millions DESC;

-- Total Laid Off by Company

SELECT company, SUM(total_laid_off) AS total_laid_off
FROM my_layoffs2
GROUP BY company
ORDER BY total_laid_off DESC;


-- Date Range

SELECT MIN(`date`) AS starting_date, MAX(`date`) AS ending_date
FROM my_layoffs2;

-- Total Laid Off by Industry

SELECT industry, SUM(total_laid_off) AS total_laid_off
FROM my_layoffs2
GROUP BY industry
ORDER BY total_laid_off DESC;

-- Total Laid Off by Country

SELECT country, SUM(total_laid_off) AS total_laid_off
FROM my_layoffs2
GROUP BY country
ORDER BY total_laid_off DESC;

-- Total Laid Off by Year

SELECT YEAR(`date`) AS `year`, SUM(total_laid_off) AS total_laid_off
FROM my_layoffs2
GROUP BY `year`
-- ORDER BY total_laid_off DESC;
ORDER BY `year` DESC;

-- Total Laid Off by Stage

SELECT stage, SUM(total_laid_off) AS total_laid_off
FROM my_layoffs2
GROUP BY stage
ORDER BY total_laid_off DESC;

-- Rolling Sum by Month

WITH rolling_table AS
(SELECT SUBSTRING(`date`,1,7) AS `month`, SUM(total_laid_off) AS laid_off
FROM my_layoffs2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `month`
ORDER BY `month`)

SELECT *,
SUM(laid_off) OVER(ORDER BY `month`) AS rolling_laid_off
FROM rolling_table;

-- Company With Total Laid Off Yearwise

SELECT company, YEAR(`date`) AS `year`, SUM(total_laid_off) AS total_laid_off
FROM my_layoffs2
GROUP BY company, `year`
ORDER BY total_laid_off DESC;

-- Ranking Yearwise Company Laid Off (Top 5)

WITH company_year AS
(SELECT company, YEAR(`date`) AS `year`, SUM(total_laid_off) AS total_laid_off
FROM my_layoffs2
WHERE YEAR(`date`) IS NOT NULL
GROUP BY company, `year`),
company_year_ranking AS
(SELECT *,
DENSE_RANK() OVER(PARTITION BY `year` ORDER BY total_laid_off DESC) AS ranking
FROM company_year)

SELECT * 
FROM company_year_ranking
WHERE ranking <=5;