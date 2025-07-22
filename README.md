# 🌍 COVID-19 Global Impact Dashboard (Tableau + SQL)

This project is an end-to-end data analysis and visualization of COVID-19’s global impact using **SQL for data transformation** and **Tableau for interactive dashboards**.
It explores total cases, deaths, infection rates, and geographic trends across continents and countries.

---

## 📊 Key Features

- **Global Summary**: Total cases, deaths, and death rate percentages.
- **Continent-level Breakdown**: Total death counts per continent.
- **Interactive Map**: Visual comparison of percent population infected per country.
- **Time-Series Forecast**: Projected infection trends by country over time.
- **Clean UX Design**: Visualized using Tableau with focus on readability and insight.

---

## 🗃️ SQL Query Highlights

A set of SQL queries was developed to prepare and enrich the dataset before visualization. Key operations include:

- Calculating global and country-level statistics such as infection rates and death percentages.
- Filtering out non-country entities (e.g., 'World', 'European Union') for cleaner visuals.
- Using `NULLIF` to prevent division-by-zero in percentage calculations.
- Aggregating and joining population data to normalize metrics.
- Structuring results using **CTEs**, **temporary tables**, and **views** for Tableau readiness.

These SQL components reflect real-world BI analyst work in data cleaning, modeling, and reporting.

---

## 🧠 Skills & Tools Demonstrated

- **SQL**: Data cleaning, joins, conditional logic, CTEs, aggregate functions
- **Tableau**: Interactive visual design, forecasting, map charts, bar & line charts
- **Data Analytics**: Population-based metrics, time-series trends, percentage calculations
- **Data Storytelling**: Clear insights across global and regional views

---

## 📁 Data Sources

> Our World in Data (https://ourworldindata.org/covid-deaths#article-citation)

---

## 🔗 Live Dashboard

[🔗 View the dashboard on Tableau Public](#) *(https://public.tableau.com/app/profile/muhamed.mustafa/viz/CovidDashboard_17427823754800/Dashboard1)*
<img width="1918" height="976" alt="image" src="https://github.com/user-attachments/assets/444b1bd1-ba1b-4a6f-a469-c5f7f2676b85" />

---

## 📌 Sample Git Commit

> “Added SQL queries for Tableau COVID-19 Analysis”  
> - Included queries for global and country-level COVID-19 statistics.  
> - Added calculations for infection rates, death percentages, and total death counts.  
> - Excluded certain locations for consistency.  
> - Used `NULLIF` to prevent division errors.  
> - Ensured population-based metrics are correctly calculated.

---

## 👤 Author

**Mohamed Mostafa Mogahed**  
*BI / Data Analyst*  
📧 muhamedmustafa9933@icloud.com  
🌍 [LinkedIn Profile](https://www.linkedin.com/in/mohamedmostafa99/)  
💻 [GitHub](https://github.com/muhamemustafa99)
 **My Portfolio: ** (https://mohamed5034.wordpress.com/about/)


---

Feel free to fork, explore, or reach out if you're interested in collaboration!
