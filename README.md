# Tariff-Shield-A-Geopolitical-Risk-Supply-Chain-Optimization

## 📘 Overview
**Tariff Shield** is a comprehensive **data analytics and risk intelligence project** built to evaluate the impact of **tariffs, trade performance, and macroeconomic factors** on global import–export dynamics.  
By integrating real-world data from **UN Comtrade, WITS**, and the **World Bank**, this project delivers deep insights into trade competitiveness, economic exposure, and country-level risk profiles — empowering data-driven policy and sourcing decisions.

The project follows a complete **ETL → SQL Analytics → Power BI Visualization → Strategic Recommendation** pipeline.

---

## 🎯 Objective
To analyze how **tariff structures** and **economic indicators** across countries influence **trade volume**, **pricing strategy**, and **import risk**, and to design a **data-driven decision system** for identifying optimal trade partners and reducing exposure to global volatility.

---

## 🧩 Data Sources

| Dataset | Source | Description |
| :-- | :-- | :-- |
| **Trade Data** | [UN Comtrade API](https://comtradeapi.un.org/) | Bilateral import/export data by product and partner country |
| **Tariff Data** | [World Integrated Trade Solution (WITS)](https://wits.worldbank.org/) | Weighted tariff rates and duty structures |
| **Economic Data** | [World Bank API](https://data.worldbank.org/) | GDP per capita, inflation, unemployment, and exchange rate data |

---

## ⚙️ Tech Stack

| Tool | Purpose |
| :-- | :-- |
| **Python (Pandas, SQLAlchemy, PyMySQL)** | Data extraction, cleaning, and loading (ETL pipeline) |
| **MySQL** | Database for KPI calculations and joins |
| **Power BI** | Visualization and dashboard creation |
| **Excel/CSV** | Raw and intermediate data validation |
| **Git & GitHub** | Version control and documentation |

---

## 🏗️ Workflow & Architecture

```text
Raw CSVs (Trade/Tariff/Economic)
        ↓
Python (Data Cleaning & ETL)
        ↓
MySQL Database (KPI Queries)
        ↓
SQL Risk & Trade Analysis
        ↓
Power BI Dashboard (Insights & Recommendations)
```

---

## 📊 Key KPIs Analyzed

### 🧮 Trade KPIs
* **Trade Balance by Country:** Surplus/deficit identification per partner.  
* **Top Importing & Exporting Countries by Product:** Market demand and supply mapping.  
* **Most Traded Product per Country:** Core trade specialization.  
* **Yearly Trade Trend:** Time-series performance for import/export growth.

### 💰 Tariff KPIs
* **Average Weighted Tariff by Country & Product:** Evaluate trade cost barriers.  
* **Tariff Impact on Trade Value:** Correlation between tariffs and trade suppression.

### 🌏 Economic KPIs
* **GDP per Capita vs Trade Volume:** Economic strength vs trade participation.  
* **Inflation vs Import Cost:** Impact of inflation on import expenses.

### 🧭 Strategic KPIs
* **Country-wise Competitive Advantage:** Profitability based on tariff and economic strength.  
* **Product Pricing Strategy:** Exchange rate and tariff-driven price insights.

### ⚠️ Risk KPIs
* **Composite Risk Score:** Combines tariff, inflation, and exchange rate volatility.  
* **High Tariff × High Import Exposure:** Identifies top-risk trade partners.  
* **Economic Instability Index:** Derived from inflation and unemployment.

---

## 📈 Power BI Dashboard Overview

### **Dashboard Sections**
1. **Trade Overview:** Import/export trends, country-wise trade volume, and balance charts.  
2. **Tariff Insights:** Average weighted tariffs by product and country, and tariff–trade correlation heatmap.  
3. **Economic Overview:** GDP, inflation, and exchange rate dynamics affecting trade.  
4. **Risk & Strategy Dashboard:** Composite risk score bars, heatmap of risk exposure, and actionable recommendation cards.

### **Design Theme**
* **Primary Color:** Deep Green (#1B4332) – symbolizes stability and growth  
* **Background:** Off-white / muted grey  
* **Text & Borders:** Charcoal grey for clarity and readability  

---

## 💡 Insights & Findings

### 🌍 Trade Insights
* **China** remains the **largest trade partner** with the USA (~$1.1T imports) but has **high tariff exposure**, making it risky under fluctuating policies.  
* **Mexico** shows strong trade volume and **moderate risk**, positioning it as the **best nearshore alternative**.  
* **Vietnam** offers **cost-effective sourcing** but suffers from **high currency volatility** (exchange rate variance: ~251.75).  
* **Bangladesh** shows **high inflation (7.2%)** and **low trade volume**, making it less viable for large-scale imports.

### 📉 Tariff & Economic Insights
* Higher tariffs consistently **suppress trade value** — countries with tariffs above 6% showed 40–50% lower import volumes.  
* **GDP per capita positively correlates with trade volume**, indicating stronger economies participate more actively in trade.  
* **Inflation impacts import costs** significantly in developing nations, eroding profit margins.

### ⚠️ Risk Insights
* **Vietnam** tops the **Composite Risk Index (54.05)** due to high currency volatility.  
* **China** has high exposure but manageable risk owing to economic stability.  
* **Bangladesh** faces economic pressure from inflation and unemployment, leading to a **risk score > 6.0** (high-risk threshold).

---

## 🧭 Strategic Recommendations

| Priority | Action | Rationale |
| :--: | :-- | :-- |
| 🔴 **High** | Reduce dependence on China for key imports | High tariff + high exposure risk |
| 🟠 **High** | Hedge currency exposure in Vietnam | Mitigate FX volatility (exchange variance > 250) |
| 🟢 **Medium** | Strengthen sourcing from Mexico | Economically stable, moderate tariffs |
| 🟢 **Medium** | Optimize product pricing | Adjust based on tariff + exchange rate differential |
| 🔵 **Low** | Monitor inflation and tariff changes quarterly | Early warning for import cost hikes |

---

## 📊 Outcome & Impact
* Built a **complete data-to-decision pipeline** integrating **3 global datasets**.  
* Designed **15+ SQL KPIs** to assess **trade, tariff, and economic performance**.  
* Developed a **country-level risk scoring model** using **normalized multi-factor aggregation**.  
* Created an **interactive Power BI dashboard** for executives to visualize global trade health.  
* Delivered **strategic sourcing and pricing recommendations** that improve trade resilience.  
* Demonstrated how **data analytics transforms trade intelligence** into *quantifiable strategy*.

---

## 🧾 Repository Contents

| File | Description |
| :-- | :-- |
| `trade_data.csv` | Cleaned trade data (UN Comtrade) |
| `tariff_data.csv` | Cleaned tariff data (WITS) |
| `economic_data.csv` | Economic indicators (World Bank) |
| `SQL_KPIs.sql` | SQL scripts for KPIs |
| `PowerBI_Dashboard.pbix` | Final Power BI report |
| `risk_model.sql` | Risk scoring framework |
| `README.md` | This documentation file |

---

## 🚀 Future Enhancements
* Integrate **real-time trade news and sentiment analysis** for geopolitical risk prediction.  
* Expand risk model to include **logistics and policy indicators**.  
* Automate Power BI refresh via Python scheduler.  
* Extend analysis to include **EU and ASEAN** trade regions.

---

## 🏁 Conclusion
**Tariff Shield** successfully bridges data analytics and global trade strategy.  
It delivers a unified view of **trade flow, tariff barriers, and economic stability**, enabling smarter and safer global sourcing.

This project demonstrates how **data-driven intelligence** can be used to make strategic trade decisions, **mitigate economic risks**, and **optimize import portfolios** for sustainable global operations.

