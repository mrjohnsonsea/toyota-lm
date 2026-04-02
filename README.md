# Toyota Corolla Price Analysis
**Georgetown MSBA — OPAN 6606: Programming I**

A data cleaning, exploratory analysis, and linear regression study in R using a dataset of 1,000 used Toyota Corollas. The goal is to understand which vehicle characteristics most strongly predict resale price.

---

## Dataset

`Toyota4.csv` — 1,000 used Toyota Corolla listings with the following features:

| Variable | Description |
|---|---|
| `Price` | Resale price (USD) |
| `Age` | Vehicle age (months) |
| `Mileage` | Odometer reading |
| `Horse_Power` | Engine horsepower |
| `Metallic_Color` | Metallic paint (1 = yes) |
| `Automatic` | Automatic transmission (1 = yes) |
| `CC` | Engine cylinder volume |
| `Doors` | Number of doors |
| `Weight` | Vehicle weight (kg) |
| `Fuel_Type` | Fuel type (Diesel, Petrol, CNG) |

---

## Analysis Steps

1. **Data Cleaning** — Identified missing values in `Mileage`; imputed with column mean.
2. **Fuel Type EDA** — Frequency table and bar chart; identified most common fuel type.
3. **Price by Fuel Type** — Boxplot distributions and average price by fuel category.
4. **Correlation Analysis** — Scatterplots and correlation coefficients for `Age` vs. `Price` and `Mileage` vs. `Price`.
5. **Outlier Removal** — Flagged and removed price outliers using z-score method (|z| > 3).
6. **Simple Regression (Age)** — `Price ~ Age`
7. **Simple Regression (Mileage)** — `Price ~ Mileage`
8. **Multiple Regression** — `Price ~ Age + Mileage`
9. **Model Comparison** — Side-by-side table of R², Adjusted R², and Residual Standard Error across all three models using `stargazer`.

---

## Tools & Packages

- **Language:** R
- **Packages:** `tidyverse`, `stargazer`

---

## Files

| File | Description |
|---|---|
| `toyota_price_analysis.R` | Full analysis script |
| `Toyota4.csv` | Raw dataset |
