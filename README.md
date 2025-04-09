# 📉 Layoffs Data Analysis Using SQL

This project investigates global tech and startup layoffs from 2020 to 2023 using **SQL-based data cleaning and exploratory analysis**. The goal is to uncover patterns in layoffs by industry, funding stage, geography, and time period.

The project was completed using:
- **MySQL** for data wrangling and querying
- **.csv dataset** as the raw data source
- **SQL scripts** for both cleaning and analysis

---

## 📁 Files Included

| File | Description |
|------|-------------|
| `layoffs.csv` | Raw dataset containing layoff data |
| `Data_Cleaning_layoffs.sql` | SQL queries for cleaning and preprocessing |
| `Data_Analysis_layoffs.sql` | SQL queries for exploratory data analysis |

---

## 🔍 Dataset Overview

- **Rows**: 2,361  
- **Columns**: 9  
- **Time Period**: From 2020 to early 2023  
- **Source**: Publicly aggregated startup and tech layoff data

### Columns:

| Column | Description |
|--------|-------------|
| `company` | Company name |
| `location` | City of operation |
| `industry` | Industry sector |
| `total_laid_off` | Number of employees laid off |
| `percentage_laid_off` | Percent of workforce laid off |
| `date` | Date of layoff event |
| `stage` | Funding stage (e.g., Series A, Post-IPO) |
| `country` | Country of operation |
| `funds_raised_millions` | Total funding raised in USD (millions) |

---

## 🧹 Data Cleaning (in `Data_Cleaning_layoffs.sql`)

The dataset required several cleaning steps before it could be analyzed:

### ✅ Steps Performed:

1. **Handled Null Values**:
   - Removed rows where `company` or `country` was NULL
   - Filtered out events with no `total_laid_off` or `date`

2. **Date Formatting**:
   - Converted `date` column (text) into actual `DATE` datatype

3. **Standardization**:
   - Trimmed and lowercased industry names for consistency
   - Removed inconsistencies in country naming

4. **Filtering Unrealistic Values**:
   - Removed rows with `total_laid_off = 0`
   - Ignored companies with invalid or placeholder names

5. **Created Derived Fields**:
   - Extracted `year`, `month`, and `quarter` from `date`

---

## 📊 Data Analysis (in `Data_Analysis_layoffs.sql`)

The cleaned dataset was explored using SQL queries to answer key questions:

### 📌 Key Analyses:

- **Which industries had the most layoffs?**
- **Top 10 companies with the highest number of laid-off employees**
- **Monthly trends of layoffs over time**
- **Layoffs by funding stage (Seed, Series A, Post-IPO, etc.)**
- **Geographic distribution of layoffs by country**
- **Average funding vs. layoffs — any correlation?**

### 📈 Insights Uncovered:

- The **tech** and **retail** industries saw the most frequent layoffs
- **Post-IPO** and **Late-stage** companies were heavily represented
- Layoffs surged in **mid to late 2022**, peaking around Q4
- Most layoffs occurred in **United States**, followed by **India** and **Canada**
- Companies with massive funding also contributed to high layoff numbers, indicating that funding does not guarantee stability

---

## 🛠 Tools Used

- **PostgreSQL** – for SQL execution and logic
- **pgAdmin / DBeaver** – for querying and result visualization
- **Microsoft Excel / Google Sheets** (optional) – for any manual inspection of `.csv`

---

## 👤 Contributor

- [Azim Nahin](https://github.com/AzimNahin)

---

## ✅ How to Reproduce

1. Load `layoffs.csv` into a SQL database table (e.g., `layoffs_raw`)
2. Run `Data_Cleaning_layoffs.sql` to clean and create `layoffs_cleaned`
3. Execute `Data_Analysis_layoffs.sql` to generate summaries and insights

---

## 📌 Example Queries (from Analysis)

```sql
-- Top 5 industries with most layoffs
SELECT industry, SUM(total_laid_off) AS total_laid_offs
FROM layoffs_cleaned
GROUP BY industry
ORDER BY total_laid_offs DESC
LIMIT 5;

-- Monthly trend of layoffs
SELECT DATE_TRUNC('month', date) AS month, SUM(total_laid_off) AS total
FROM layoffs_cleaned
GROUP BY month
ORDER BY month;
