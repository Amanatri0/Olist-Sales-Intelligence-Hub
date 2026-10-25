# Olist E-Commerce Analytics

**An end-to-end e-commerce analytics project using SQL, Python, and Looker Studio.**

This project analyzes the Brazilian Olist e-commerce marketplace to understand sales performance, product and category demand, merchandise value, customer satisfaction, and delivery operations. It combines SQL-based business analysis, data-quality validation, Python-assisted data ingestion, and interactive business intelligence dashboards.

> **Project status:** Sales & Revenue Intelligence and Product & Category Intelligence dashboards completed. Logistics analysis is the next phase.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Business Objectives](#business-objectives)
- [Tools and Technologies](#tools-and-technologies)
- [Dataset](#dataset)
- [Project Workflow](#project-workflow)
- [Dashboard Gallery](#dashboard-gallery)
- [Key Findings](#key-findings)
- [SQL Analysis](#sql-analysis)
- [Data Quality and Methodology](#data-quality-and-methodology)
- [Repository Structure](#repository-structure)
- [How to Reproduce the Analysis](#how-to-reproduce-the-analysis)
- [Current Status and Next Steps](#current-status-and-next-steps)
- [Limitations](#limitations)

---

## Project Overview

The objective of this project is to transform raw e-commerce data into structured business insights that can support decision-making.

The analysis follows a business-question-driven approach. Instead of producing charts without context, each analytical section investigates a specific business problem, develops the relevant SQL metrics, validates the results, and presents the findings through dashboards.

The reporting window used for the current sales and category analyses is **January 2017 through August 2018**, with September 1, 2018, excluded from the date filter.

### Business domains

| Domain | Analytical focus | Status |
|---|---|---|
| Sales & Revenue | Order volume, sales trends, revenue and payment behaviour | Dashboard completed |
| Product & Category | Category demand, merchandise value, product rankings and satisfaction | Dashboard completed |
| Customer | Customer behaviour and review analysis | Further analysis planned |
| Logistics | Delivery duration, late deliveries and delivery performance | Next phase |
| Seller | Seller performance and related business questions | Planned |

---

## Business Objectives

The project investigates questions such as:

- How does order volume change over time?
- Which product categories generate the highest merchandise value?
- Which categories attract the most orders?
- Which individual products appear in the highest number of distinct orders?
- Which categories have high order volume but low merchandise value per order?
- Which high-value categories have below-median customer satisfaction?
- Which categories are associated with longer delivery times?
- What operational patterns can be identified from order and delivery data?

The questions are organized by business domain in the project's question bank. Their completion status is tracked separately from the overall project status.

---

## Tools and Technologies

| Technology | Purpose |
|---|---|
| MySQL | Data storage, joins, aggregation, business analysis and validation |
| SQL | Business-question analysis, CTEs, window functions and KPI calculations |
| Python | Data ingestion and automation |
| Jupyter Notebook | Data understanding and exploratory work |
| Looker Studio | Interactive dashboards and business reporting |
| Git and GitHub | Version control, documentation and project portfolio |

---

## Dataset

**Source:** [Brazilian E-Commerce Public Dataset by Olist — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The dataset contains records from a Brazilian e-commerce marketplace, including orders, order items, customers, sellers, products, payments, reviews and geolocation information.

The original dataset contains multiple related CSV files. These are loaded into MySQL and analyzed through joins between the relevant tables.

The core tables used in the current product and category analysis include:

- `orders`
- `order_items`
- `products`
- `product_translation`
- `order_reviews`

The product translation table is used to display English category names. Analyses that use an inner join to this table include only categories with a matching translation unless explicitly stated otherwise.

**Reporting period:** January 1, 2017, to August 31, 2018, inclusive, for the analyses using the current date filter.

The raw data is not intended to be duplicated in this repository. Follow the dataset source link and the local setup instructions to obtain the files.

---

## Project Workflow

The project follows these stages:

1. **Data ingestion:** Load the source data into MySQL using a Python-assisted import workflow.
2. **Data understanding:** Inspect tables, columns, data types, relationships and record counts.
3. **Data quality assessment:** Investigate missing values, repeated identifiers, mapping gaps and other potential data issues.
4. **SQL analysis:** Answer business questions using joins, aggregation, CTEs, conditional logic and window functions.
5. **Metric validation:** Check aggregation grain, distinct-order counts, date boundaries and metric definitions.
6. **Business interpretation:** Translate query results into findings and identify areas requiring further investigation.
7. **Dashboard development:** Present validated results in Looker Studio.
8. **Documentation and version control:** Maintain SQL files, business-question documentation, dashboard screenshots and project notes in GitHub.

---

## Dashboard Gallery


### 1. Overview Dashboard

**Purpose:** Provide a high-level view of marketplace performance and navigation into the detailed analytical sections.

![Overview Dashboard](/assetes/dashboards/overview.jpg)


### 2. Sales & Revenue Intelligence

**Purpose:** Examine order activity, sales trends, merchandise value and other revenue-related business questions.

![Sales and Revenue Dashboard](/assetes/dashboards/sales&Revenue.jpg)


### 3. Product & Category Intelligence

**Purpose:** Compare category demand, merchandise value, and customer satisfaction, and identify high-performing product categories.

![Product and Category Intelligence Dashboard](/assetes/dashboards/product&Categories.jpg)


### 4. Category Performance & Satisfaction

**Purpose:** Investigate categories with above-median merchandise value per category-containing order and below-median average review scores.

![Category Performance and Satisfaction Dashboard](/assetes/dashboards/customerSatisfaction.jpg)


---

## Key Findings

The following findings come from the SQL analyses completed for the current reporting window. Merchandise value refers to the sum of item prices and excludes freight charges.

### Category demand

- **Bed & Bath Table** recorded 9,412 distinct orders containing items from the category.
- **Health & Beauty** recorded 8,791 distinct orders.
- **Sports & Leisure** recorded 7,701 distinct orders.

These counts measure distinct orders containing each category. They should not be added together to estimate total marketplace orders because a single order can contain products from multiple categories.

### Merchandise value

The highest merchandise-value categories in the analyzed period included:

| Category | Merchandise value |
|---|---:|
| Health & Beauty | R$1,253,993.86 |
| Watches & Gifts | R$1,201,645.44 |
| Bed & Bath Table | R$1,036,509.69 |
| Sports & Leisure | R$984,715.33 |
| Computers & Accessories | R$910,555.00 |

These figures represent merchandise item value, not net profit, seller earnings or total customer expenditure including freight.

### Category value per order

The median category merchandise value per order was **R$125.62**.

This metric is calculated as the category's total item value divided by the number of distinct orders containing that category. It is not the same as average total order value across the entire marketplace.

### Customer satisfaction

The median average category review score was **4.13 out of 5**.

The category satisfaction analysis identified 19 categories meeting both of the following conditions:

- Merchandise value per category-containing order above the median.
- Average category review score below the median.

Office Furniture recorded an average category review score of **3.62 across 1,258 reviewed orders**, making it a more substantial investigation priority than categories with very small review samples.

Security & Services recorded a score of 2.50 across only two reviewed orders. This result is retained in the analysis but should not be treated as strong evidence of category-wide dissatisfaction.

### Individual product demand

Product rankings use the number of distinct orders containing each product. This differs from counting order-item records, because an order can contain multiple item records for the same product.

The analysis ranks products within their translated product categories using SQL window functions.

---

## SQL Analysis

SQL files are organized by business domain so that each query can be inspected independently.

| Folder | Purpose |
|---|---|
| `sql/00_setup/` | Database setup and schema |
| `sql/01_data_quality/` | Data-quality checks and validation |
| `sql/02_sales_revenue/` | Sales and revenue questions |
| `sql/03_product_category/` | Product, category and satisfaction questions |
| `sql/04_logistics/` | Delivery and logistics analysis |
| `sql/05_customer/` | Customer analysis |
| `sql/06_seller/` | Seller analysis |

The product and category analysis includes:

- **Q3:** Category order activity, using distinct order counts.
- **Q7:** Category merchandise value, using the sum of item prices.
- **Q8:** Individual product rankings based on distinct orders, including ranking within categories.
- **Q30:** Categories with high merchandise value per order and below-median satisfaction.
- **Q31:** Categories with high order volume but below-median merchandise value per order.

The full question register and the individual SQL files provide the detailed definitions and implementation for each question.

---
<!-- 
## Data Quality and Methodology

Data quality is treated as part of the analysis, not as a separate cosmetic step.

### Distinct orders versus order-item records

`COUNT(DISTINCT order_id)` counts unique orders containing the relevant product or category.

`COUNT(*)` or `COUNT(product_id)` counts rows at the order-item grain when applied to the order-items table. These metrics are not interchangeable.

### Merchandise value

The current category merchandise-value calculations use `SUM(order_items.price)`. Freight is excluded. Consequently, the metric should not be labelled as profit or total customer expenditure.

### Category value per order

The metric is calculated as:

**Category merchandise value per order = Category merchandise value / Distinct orders containing that category**

Because orders can contain multiple categories, category-level order counts overlap.

### Median classification

High and low classifications use the median across the analyzed categories as a reference point. These classifications are relative to this dataset and reporting window; they are not universal business thresholds.

### Review data

The review table was investigated for repeated review identifiers and multiple review records associated with an order. The category satisfaction analysis aggregates review scores at the order level before associating reviewed orders with categories, avoiding a direct multiplication of review rows by individual order-item rows.

Review counts and scores must be interpreted with the relevant sample size in mind. -->

### Reporting window

Date filters use a lower-inclusive and upper-exclusive interval:

- Start: `2017-01-01`
- End: `2018-09-01`, excluded

This includes January 2017 through August 2018 without including records from September 1, 2018, onward.

---

## Repository Structure

The intended repository structure is:

```text
olist-ecommerce-analytics/
├── README.md
├── .gitignore
├── data/
│   └── README.md
├── scripts/
│   └── data_import.py
├── notebooks/
│   └── 01_data_understanding.ipynb
├── sql/
│   ├── 00_setup/
│   ├── 01_data_quality/
│   ├── 02_sales_revenue/
│   ├── 03_product_category/
│   ├── 04_logistics/
│   ├── 05_customer/
│   └── 06_seller/
├── assets/
│   └── dashboards/
├── docs/
│   ├── business-question-register.md
│   ├── data-dictionary.md
│   └── methodology.md
└── reports/
```

The final directory names may differ slightly from this proposed layout. Links in this README should match the actual committed paths.

Raw datasets, local working files, credentials and environment-specific configuration should not be committed unnecessarily. The data directory should explain how to obtain the source data.

---

## How to Reproduce the Analysis

The following workflow describes the intended reproduction process. Exact setup instructions should be updated to match the final scripts and SQL files.

### Prerequisites

- MySQL
- Python and the dependencies required by the ingestion script
- Jupyter Notebook, if using the notebook workflow
- Looker Studio for viewing or rebuilding the dashboards

### Steps

1. Download the Olist dataset from the linked [Kaggle source](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).
2. Place the CSV files in the documented local data directory.
3. Configure the MySQL connection using local credentials or environment variables. Do not commit passwords.
4. Create the database and tables using the setup scripts.
5. Run the Python data-ingestion workflow to import the source files.
6. Execute the SQL queries for the relevant business domain.
7. Review the documented metric definitions and data-quality checks.
8. Use the validated outputs to build or refresh the Looker Studio reports.

The repository will include the precise commands, table setup instructions and any required Python packages as these are documented and validated.

---

## Current Status and Next Steps

### Completed

- SQL-based sales and revenue analysis and its dashboard.
- Product and category analysis.
- Individual product rankings using distinct order counts and category-level window functions.
- Median-based category performance classification.
- Category satisfaction analysis and review-data quality investigation.
- Product & Category Intelligence dashboard.
- Category Performance & Satisfaction table.
- Initial Python-assisted data-ingestion workflow.
- Project question bank and analytical documentation.

### In progress / planned

- Organize SQL files by business domain.
- Add dashboard screenshots and explanations to the repository.
- Finalize the root README and reproduction instructions.
- Begin Logistics analysis, starting with the question about categories associated with longer delivery times.
- Continue customer and seller analysis according to the business-question register.
- Add the remaining validated findings and dashboards as the project progresses.

---

## Limitations

- The reporting window covers January 2017 through August 2018 for the analyses described above; findings should not be generalized to later periods without further analysis.
- Merchandise value excludes freight and does not represent profit.
- Category-level order counts can overlap because one order may contain multiple categories.
- Median-based classifications are relative to the categories in the selected dataset and reporting window.
- Some categories have very small review samples, so their average scores require cautious interpretation.
- The project is ongoing. Planned analyses should not be interpreted as completed findings.

---

## Author

**Aman Atri**

Data analytics portfolio project focused on SQL, Python, data quality, business analysis, and business intelligence reporting.

This repository documents the analytical process, queries, assumptions, validation steps and business findings—not just the final charts.
