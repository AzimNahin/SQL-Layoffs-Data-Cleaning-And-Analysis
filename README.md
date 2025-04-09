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

The raw `layoffs.csv` dataset was imported into MySQL and cleaned using structured SQL logic. Below are the precise data cleaning steps carried out:

### 1. 🔄 Create Working Table
- A duplicate table was created from the original to preserve the raw data.

### 2. ❌ Remove Duplicate Records
- Duplicate rows were identified based on all major columns and removed to ensure each layoff event was unique.

### 3. 🧽 Standardize Text Fields
- Company names were trimmed to remove extra whitespace.
- Industry labels were standardized (e.g., all variations of "Crypto" were unified under one label).
- Country names were made consistent by resolving variations (e.g., "United States." was replaced with "United States").

### 4. 🗓️ Fix Date Format
- The date field was converted from text to a proper date format to enable time-based analysis.

### 5. 🛠 Fill Missing Values
- Missing values in the `industry` column were filled using matching company names from other complete rows.

### 6. 🗑️ Remove Irrelevant Rows
- Rows where both the total number and percentage of layoffs were missing were removed, as they provided no analytical value.

### 7. ✅ Finalize Cleaned Table
- A final cleaned version of the dataset was saved for analysis, with helper columns removed and structure standardized.

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
- Most layof## 📊 Data Analysis (in `Data_Analysis_layoffs.sql`)

The cleaned dataset was explored using SQL queries in MySQL to extract patterns and trends related to layoffs.

### 📌 Key Analyses Performed:

- Company with the **maximum and minimum** number of employees laid off
- Company with the **highest and lowest** percentage of workforce laid off
- **Total layoffs by industry**
- **Layoffs by country**
- **Layoffs by year**
- **Layoffs by company funding stage**
- **Rolling monthly layoff trend** across all years
- **Top companies by total layoffs per year**
- **Top 5 companies each year** (ranked yearly by layoffs)

### 📈 Insights Uncovered:

- **Tech**, **Retail**, and **Transportation** industries had the highest total layoffs
- The majority of layoffs occurred in **2022**, with a noticeable peak in Q4
- The **United States** had the highest number of layoffs, followed by **India**
- **Post-IPO** and **Late Stage** companies experienced large-scale layoffs
- Companies like **Meta**, **Amazon**, and **Byju's** frequently appeared in the yearly top 5
- A continuous rise in layoffs was visible through the **rolling monthly total**

---

## 🛠 Tools Used

- **MySQL (8.0)** – SQL execution and logic
- **MySQL Workbench / DBeaver** – for querying and result visualization
- **CSV (`layoffs.csv`)** – original raw dataset used for importing
fs occurred in **United States**, followed by **India** and **Canada**
- Companies with massive funding also contributed to high layoff numbers, indicating that funding does not guarantee stability

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
