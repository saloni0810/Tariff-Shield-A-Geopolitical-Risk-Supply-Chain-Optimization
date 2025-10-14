use tariff_shield_db;
select * from economic_data;
select * from tariff_data;
select * from trade_data;
-- ****************************
-- NEW KPIS
-- ****************************
-- 1. Top Importing Country by Product
SELECT 
    cmdCode AS product,
    partnerDesc AS country,
    SUM(primaryValue) AS total_imports
FROM trade_data
WHERE flowDesc = 'Import'
GROUP BY cmdCode, partnerDesc
ORDER BY total_imports DESC;

-- 2. Yearly Trade Trend
SELECT 
    year,
    flowDesc,
    SUM(primaryValue) AS total_trade
FROM trade_data
GROUP BY year, flowDesc
ORDER BY year, flowDesc;

-- 3. Trade Balance by Country
SELECT 
    partnerDesc AS country,
    SUM(CASE WHEN flowDesc = 'Import' THEN primaryValue ELSE 0 END) AS trade_balance
FROM trade_data
GROUP BY partnerDesc
ORDER BY trade_balance DESC;

-- 4. Most Traded Product per Country
SELECT 
    partnerDesc AS country,
    cmdCode AS product,
    SUM(primaryValue) AS total_trade_value
FROM trade_data
GROUP BY partnerDesc, cmdCode
HAVING SUM(primaryValue) = (
    SELECT MAX(total_value)
    FROM (
        SELECT partnerDesc, cmdCode, SUM(primaryValue) AS total_value
        FROM trade_data
        GROUP BY partnerDesc, cmdCode
    ) sub
    WHERE sub.partnerDesc = trade_data.partnerDesc
);

-- Tariff KPIs
-- 1. Average Tariff Rate by Product & Country
SELECT 
    `Partner Name` AS country,
    Product AS product,
    ROUND(AVG(`Weighted Average`), 2) AS avg_tariff
FROM tariff_data
GROUP BY `Partner Name`, Product
ORDER BY avg_tariff DESC;

-- 2. Highest Tariff Product per Country
SELECT 
    `Partner Name` AS country,
    Product AS product,
    `Weighted Average` AS tariff_rate
FROM tariff_data t1
WHERE `Weighted Average` = (
    SELECT MAX(`Weighted Average`) 
    FROM tariff_data t2
    WHERE t1.`Partner Name` = t2.`Partner Name`
);

-- 3. Tariff Impact on Trade Value
SELECT 
    t.`Partner Name` AS country,
    t.Product AS product,
    ROUND(AVG(t.`Weighted Average`), 2) AS avg_tariff,
    SUM(tr.primaryValue) AS total_trade_value
FROM tariff_data t
JOIN trade_data tr
    ON t.`Partner Name` = tr.partnerDesc
   AND t.Product = tr.cmdCode
GROUP BY t.`Partner Name`, t.Product
ORDER BY avg_tariff DESC;

-- Economic KPIs
-- 1. GDP per Capita vs Trade Volume
SELECT 
    e.country,
    ROUND(AVG(e.gdp_per_capita), 2) AS avg_gdp_per_capita,
    SUM(t.primaryValue) AS total_trade_value
FROM economic_data e
JOIN trade_data t 
    ON e.country = t.partnerDesc
   AND e.year = t.year
GROUP BY e.country
ORDER BY total_trade_value DESC;

-- 2. Unemployment Rate vs Trade Dependency
SELECT 
    e.country,
    ROUND(AVG(e.unemployment_rate), 2) AS avg_unemployment,
    SUM(t.primaryValue) AS total_imports
FROM economic_data e
JOIN trade_data t 
    ON e.country = t.partnerDesc
   AND e.year = t.year
WHERE t.flowDesc = 'Import'
GROUP BY e.country
ORDER BY avg_unemployment DESC;

-- 3. Exchange Rate Volatility Impact
SELECT 
    e.country,
    ROUND(AVG(e.exchange_rate), 2) AS avg_exchange_rate,
    STDDEV(e.exchange_rate) AS exchange_rate_volatility,
    SUM(t.primaryValue) AS total_trade_value
FROM economic_data e
JOIN trade_data t 
    ON e.country = t.partnerDesc
   AND e.year = t.year
GROUP BY e.country
ORDER BY exchange_rate_volatility DESC;

-- 4. Inflation vs Import Cost
SELECT 
    e.country,
    ROUND(AVG(e.inflation_rate), 2) AS avg_inflation,
    SUM(t.primaryValue) AS total_imports
FROM economic_data e
JOIN trade_data t 
    ON e.country = t.partnerDesc
   AND e.year = t.year
WHERE t.flowDesc = 'Import'
GROUP BY e.country
ORDER BY avg_inflation DESC;

-- Strategic KPIs
-- 1. Product Manufacturing Feasibility
SELECT 
    t.`Partner Name` AS country,
    t.Product AS product,
    ROUND(AVG(t.`Weighted Average`), 2) AS avg_tariff,
    ROUND(AVG(e.unemployment_rate), 2) AS avg_unemployment
FROM tariff_data t
JOIN economic_data e 
    ON t.`Partner Name` = e.country
   AND t.`Tariff Year` = e.year
GROUP BY t.`Partner Name`, t.Product
ORDER BY avg_unemployment DESC, avg_tariff ASC;

-- 2 Product Pricing Strategy
SELECT 
    t.`Partner Name` AS country,
    t.Product AS product,
    ROUND(AVG(t.`Weighted Average`), 2) AS avg_tariff,
    ROUND(AVG(e.exchange_rate), 2) AS avg_exchange_rate,
    SUM(tr.primaryValue) AS total_trade_value
FROM tariff_data t
JOIN economic_data e 
    ON t.`Partner Name` = e.country
   AND t.`Tariff Year` = e.year
JOIN trade_data tr
    ON t.`Partner Name` = tr.partnerDesc
   AND t.Product = tr.cmdCode
   AND tr.year = e.year
GROUP BY t.`Partner Name`, t.Product
ORDER BY avg_tariff DESC, avg_exchange_rate DESC;

-- 3 Country-wise Competitive Advantage
SELECT 
    t.`Partner Name` AS country,
    t.Product AS product,
    SUM(tr.primaryValue) AS total_trade_value,
    ROUND(AVG(t.`Weighted Average`), 2) AS avg_tariff,
    ROUND(AVG(e.gdp_per_capita), 2) AS avg_gdp_per_capita
FROM trade_data tr
JOIN tariff_data t 
    ON tr.partnerDesc = t.`Partner Name` 
   AND tr.cmdCode = t.Product
   AND tr.year = t.`Tariff Year`
JOIN economic_data e 
    ON tr.partnerDesc = e.country
   AND tr.year = e.year
GROUP BY t.`Partner Name`, t.Product
ORDER BY total_trade_value DESC, avg_gdp_per_capita DESC;

-- Composite Risk Score (Country-Level)
SELECT 
    t.`Partner Name` AS country,
    ROUND(AVG(t.`Weighted Average`),2) AS avg_tariff,
    ROUND(AVG(e.inflation_rate),2) AS avg_inflation,
    ROUND(STDDEV_POP(e.exchange_rate),2) AS exch_volatility,
    -- Simple risk proxy: Tariff + Inflation + Exchange Volatility
    (0.5*AVG(t.`Weighted Average`) 
     + 0.3*AVG(e.inflation_rate) 
     + 0.2*STDDEV_POP(e.exchange_rate)) AS risk_score
FROM tariff_data t
JOIN economic_data e 
    ON t.`Partner Name` = e.country
GROUP BY t.`Partner Name`
ORDER BY risk_score DESC;

-- High Tariff × High Import Exposure
SELECT 
    t.`Partner Name` AS country,
    SUM(td.primaryValue) AS total_imports,
    ROUND(AVG(t.`Weighted Average`),2) AS avg_tariff,
    (SUM(td.primaryValue) * AVG(t.`Weighted Average`)) AS tariff_exposure
FROM tariff_data t
JOIN trade_data td 
    ON t.`Partner Name` = td.partnerDesc 
   AND t.Product = td.cmdCode
WHERE td.flowDesc = 'Import'
GROUP BY t.`Partner Name`
ORDER BY tariff_exposure DESC;

-- Economic Instability Risk
SELECT 
    country,
    ROUND(AVG(inflation_rate),2) AS avg_inflation,
    ROUND(AVG(unemployment_rate),2) AS avg_unemployment,
    (0.6*AVG(inflation_rate) + 0.4*AVG(unemployment_rate)) AS econ_risk_score
FROM economic_data
GROUP BY country
ORDER BY econ_risk_score DESC;
