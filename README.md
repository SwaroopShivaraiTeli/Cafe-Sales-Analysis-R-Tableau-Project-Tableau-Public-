# Cafe-Sales-Analysis-R-Tableau-Project-Tableau-Public-
# ☕ Cafe Sales Analysis (R + Tableau)

This project involves cleaning and analyzing a **dirty café sales dataset** using **R**, followed by visualizing insights using **Tableau Public**. It covers data wrangling, exploration, and visualization for business decision-making.

---

## 📁 Project Structure

## 🧼 Step 1: Data Cleaning in R

**Tools Used:** `base R`, `dplyr`, `ggplot2`

### 🔹 Tasks Performed

1. **Loaded CSV Data** with `stringsAsFactors = FALSE`.
2. **Cleaned `Total.Spent`** column:
   - Removed non-numeric values (like `"ERROR"`)
   - Converted to numeric
   - Replaced `NA` with **mean value** of total spent

3. **Cleaned `Payment.Method`**:
   - Trimmed white space
   - Replaced `"UNKNOWN"`, `"ERROR"`, and blanks with `"Missing"`

4. **Cleaned `Transaction.Date`**:
   - Removed invalid entries (`"ERROR"`, `"UNKNOWN"`, blanks)
   - Converted to proper `Date` format
   - Extracted **Year** and **Month** from transaction date

5. **Cleaned `Item` and `Location`**:
   - Replaced invalid item entries with `"Unknown"`
   - Replaced missing or corrupt locations with `"Missing"`

---

## 📊 Step 2: Visual Analysis in R

### 🔸 Monthly Sales Trend
- Plotted total sales over months in 2023 using `ggplot2`

### 🔸 Top 5 Café Items by Revenue
- Aggregated `Total.Spent` by `Item`
- Created bar chart of top-selling items

### 🔸 Monthly Trend of Top 3 Items
- Filtered top 3 items
- Visualized monthly trend using `line + point` plot

### 🔸 Revenue by Payment Method
- Grouped by `Payment.Method`
- Visualized using horizontal bar chart

### 🔸 Revenue by Location
- Summarized and visualized total sales from `In-store`, `Takeaway`, and others

---

## 📈 Step 3: Interactive Dashboard in Tableau

We uploaded the cleaned CSV file and built the following:

### ✅ Visualizations Included
1. **Monthly Sales Trend (Line Chart)**
2. **Top 5 Items by Revenue (Bar Chart)**
3. **Monthly Revenue Trend of Top 3 Items (Multi-line Chart)**
4. **Revenue by Payment Method (Horizontal Bar Chart)**
5. **Revenue by Location (Bar Chart)**

---

## 🌐 View Dashboard on Tableau Public

🔗 [https://public.tableau.com/views/YOUR-DASHBOARD](https://public.tableau.com/authoring/CafeSalesAnalysisRTableauProject/CafeSalesDashboard#2)

  

---

## ✅ Final Export

Cleaned dataset saved to:
```bash
cafe_sales_cleaned.csv


##Exported using:
write.csv(df, "D:/R Langauge/Projects/Cafe_Sales_R_Project/cafe_sales_cleaned.csv", row.names = FALSE)



