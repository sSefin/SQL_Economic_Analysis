# Global Macro Analysis: Inflation, Policy & Human Outcomes 

A SQL-based multi-country economic analysis of inflation, inequality, and resilience.

## Introduction
This SQL-based analytics project analyses the economic health, inequality, and inflation policy response of 7 countries during the post-COVID period. It explores how nations of varying economic structures responded to one of the most significant global inflation crises in recent history.

## Data Sources
All datasets are sourced from reputable institutional and government sources. No simulated or crowd-sourced data was used.

| Dataset | Source | Link |
|---|---|---|
| 🌍 CPI / Inflation | World Bank Global Inflation Database | [World Bank](https://worldbank.org/en/research/brief/inflation-database) |
| 📈 GDP per Capita (PPP) | World Bank | [World Bank](https://data.worldbank.org/indicator/NY.GDP.PCAP.PP.CD) |
| 👷 Unemployment Rate (Global) | OECD | [OECD](https://data.oecd.org/unemp/unemployment-rate.htm) |
| 👷 Unemployment Rate (India) | World Bank / ILO | [World Bank](https://data.worldbank.org/indicator/SL.UEM.TOTL.ZS?locations=IN) |
| 👷 Unemployment Rate (Brazil) | IBGE | [IBGE](https://ibge.gov.br) |
| 🏦 Policy Rate (USA) | FRED | [FRED](https://fred.stlouisfed.org) — FEDFUNDS |
| 🏦 Policy Rate (Australia) | Reserve Bank of Australia | [RBA](https://rba.gov.au/statistics/cash-rate) |
| 🏦 Policy Rate (UK) | DataHub / Bank of England | [DataHub](https://datahub.io/core/interest-rates-gb) |
| 🏦 Policy Rate (Germany/ECB) | FRED | [FRED](https://fred.stlouisfed.org) — ECBMRRFR |
| 🏦 Policy Rate (Japan) | FRED | [FRED](https://fred.stlouisfed.org) — IRSTCB01JPM156N |
| 🏦 Policy Rate (India) | RBI Official Decisions | [Trading Economics](https://tradingeconomics.com/india/interest-rate) |
| 🏦 Policy Rate (Brazil) | FRED | [FRED](https://fred.stlouisfed.org) — IRSTCB01BRM156N |
| 🌱 Quality of Life Index | Numbeo | [Numbeo](https://numbeo.com/quality-of-life/rankings_by_country.jsp) |
| ⚖️ Gini Coefficient | Our World in Data | [Our World in Data](https://ourworldindata.org/grapher/economic-inequality-gini-index) |
| 🧬 Human Development Index | Our World in Data / UNDP | [Our World in Data](https://ourworldindata.org/grapher/human-development-index) |

## Skills Used
- Power Query
- CTEs 
- JOINs
- Window Functions
- Aggregate Functions
- CASE Functions
- NULLIF
- Min-Max Normalisation
- Schema Design & Data Modelling

## Data Transformation

### 🔧 Data Preparation - PowerQuery
- Filtered datasets to 7 target countries (Australia, USA, UK, Germany, Japan, India, Brazil)
- Filtered date ranges to project period (2020 onwards)
- Promoted first rows to headers where required
- Renamed columns to consistent `snake_case` format
- Unpivoted columns from wide format (years as columns) to long format (rows)
- Extracted year, month, and quarter from date columns
- Grouped data by time period using `MAX` aggregation to remove intra-period duplicates
- Added country name column manually using a custom column formula
- Converted Gini coefficient from a decimal scale (0-1) to a percentage scale (0-100)
- Manually constructed small reference datasets where bulk download was unavailable

### 🗄️ Data Analysis - SQL
- Designed normalised schema with 7 tables using appropriate data types
- Applied `SERIAL PRIMARY KEY` and `UNIQUE` constraints for data integrity
- Averaged quarterly CPI to an annual frequency using `AVG` and `GROUP BY`
- Averaged monthly policy rates to an annual frequency using `AVG` and `GROUP BY`
- Filtered monthly policy rates to a quarterly frequency using a `WHERE IN` clause
- Joined multiple tables using `LEFT JOIN` on composite keys (`country` + `year`)
- Applied `LAG(cpi, 4)` window function to calculate year-over-year quarterly inflation rates from quarters
- Used chained CTEs to layer transformations sequentially before the final `SELECT` block
- Applied min-max normalisation scaled from 0-100 for composite economic health scoring
- Ranked countries annually using the `RANK()` window function partitioned by year

---

## Analysis Overview  

### [Annual Macro Overview](/Queries/economic_development_indicators_all.sql)

<img width="1353" height="796" alt="overall_analysis" src="https://github.com/user-attachments/assets/ebfcac49-1c2b-4b8a-b647-ab6160e71885" />



Combines all 7 economic indicator tables into a single annual view across 7 countries from 2020-2024. This serves as the foundation dataset for the project, providing a complete picture of each country's economic profile before executing deeper analysis.

> ⚠️ **Note on HDI:** HDI data is not available from 2024 due to the retrospective nature of its data collection. It is published with an intrinsic 1-2 year lag by the UNDP due to the structural complexity of compiling global indicators.
> 
> ⚠️ **Note on Gini:** The Gini coefficient is collected through national household income surveys conducted every 2-5 years depending on the country, resulting in data gaps for non-survey years.

### [Inequality Analysis](/Queries/Inequality_analysis.sql)
Inequality classifications are categorized based on the Gini Coefficient. Countries with low Gini coefficients on the near years are automatically assumed as low Gini.

<img width="435" height="795" alt="Inequality_Analysis" src="https://github.com/user-attachments/assets/2f2c826e-531c-441d-be64-1275431a964f" />


#### Findings:
* **Socio-Economic Correlations:** There is a strong positive correlation between inequality and unemployment, alongside a corresponding negative correlation between inequality and quality of life. Countries with lower Gini coefficients consistently demonstrated lower structural unemployment rates and higher QOL scores throughout the 2020-2026 timeline.
* **The US Exception:** This pattern does not hold for the United States. Despite high inequality (Gini 41.8), the USA maintains low unemployment and high QOL. This is attributed to the world's largest and most dynamic labour market, where absolute economic scale and productivity offset the negative social drag of baseline inequality.
* **Brazil's Volatility & Turnaround:** Brazil exhibited the highest unemployment (14.90% in 2021) and the lowest QOL (104.7) among all 7 countries, which aligns with its high inequality index (Gini 51.6). However, unemployment improved significantly to 6.10% by 2026 and QOL showed a gradual recovery, suggesting that Brazil's aggressive, forward-leaning monetary policy response successfully stabilized the real economy.
* **Low-Inequality Performance:** Among low-inequality countries, no single nation dominates across all metrics. Japan leads on labor market efficiency (2.80% unemployment in 2022), Australia dominates on lifestyle stability (183.8 QOL in 2022), while Germany maintains the strongest balanced profile across all indicators.

### [Inflation Policy Analysis](/Queries/Inflation_policy_analysis.sql)

<img width="627" height="611" alt="Inflation_policy_analysis" src="https://github.com/user-attachments/assets/14319dc8-de2c-4070-bd11-b987c93965b2" />


The inflation rate is calculated based on changes in CPI over time. The policy rate is fixed by the respective central banks in response to inflation shocks; generally, higher inflation triggers a tighter monetary policy response.

> ⚠️ **Note on Data:** This data is queried to focus exclusively on key inflection points of the inflation crisis only.

#### Findings:
* **The Post-COVID Surge:** Developed countries in the dataset experienced deflation or near-deflation conditions at the start of COVID-19. However, supply chain shocks and fiscal stimulus pushed inflation to historical peaks during 2022.
* **Brazil's Early Tightening Proactivity:** Brazil reacted earliest and most aggressively. When its domestic inflation peaked at 11.92%, policy rates had already been jacked up to 13.25%. Brazil was dealing with unique domestic inflationary bottlenecks before global post-COVID supply inflation materialized, explaining its elevated rate baseline.
* **The Eurozone Lag:** Germany's interest rate framework was held at minimum levels by the ECB until inflation had already peaked, representing a more reactive monetary stance.
* **Japan's Outlier Strategy:** Japan consistently refused to raise its policy rate despite breaching its inflation targets, operating on the structural analysis that its inflation was transient and cost-push driven entirely by external commodity imports.
* **Australia's Disciplined Disinflation:** Australia achieved the fastest structural disinflation. CPI inflation peaked at 7.83% in Q4 2022 and fell to 2.42% by Q4 2024—a 5.41 percentage point drop in just two years. The cash rate peaked at 4.35% and was held there for a highly disciplined macroeconomic response.
* **The UK's Stagflation Persistence:** UK inflation proved to be the most sticky and persistent, remaining near double digits into Q1 2023, nearly three-quarters of a year after the USA's inflation trajectory had turned downward. The UK took longer to control price pressures than any other developed economy in the dataset.

### [Overall Economic Health Analysis](/Queries/Economic_health_analysis.sql)

<img width="655" height="404" alt="Economic Health Analysis" src="https://github.com/user-attachments/assets/d787fa9f-6447-4cd6-9937-97dc150e36e6" />


Economic health analysis normalises raw values into a standardized index ranging from 0 to 100 (where 0 represents the worst regional performer and 100 represents the optimal performer for any given indicator). Countries are then evaluated across all performance variables to compute a final balanced composite health score, which ranks overall resilience from 2020 to 2023.

> ⚠️ **Note on Scope:** Data tracking concludes at 2023 due to the systemic unavailability of Gini, HDI, and specialized QOL metrics past this period.
> 
> ⚠️ **Note on Index Weights:** The Gini coefficient is explicitly excluded from the final composite scoring architecture to avoid skewing the model, as it is only surveyed an average of once every three years globally.

#### Findings:
* **The Top Tier Leaderboard:** Germany secured the highest average structural performance score in the country index, with Japan closely competing due to pristine labour markets and exceptional price stability.
* **Underperformance Benchmarks:** Brazil dropped to the bottom tier spot thrice across the timeline, while India recorded the lowest composite index ranking once.
* **The US Growth vs. Inflation Trade-off:** The United States maintained the absolute highest raw GDP score in 3 out of 4 years. However, its aggressive inflation surge significantly penalized its overall score, driving its aggregate rank down.
* **Australia's Stability Anchoring:** Australia proved to be the most consistent and resilient performer in the dataset, locking down the Rank 3 spot for four consecutive years.
* **Divergent Growth Strategies Visualized:** The normalization engine clearly highlights contrasting national economic strategies: the US relies heavily on explosive GDP output, Japan sustains competitive ranking via labor efficiencies and price controls, while Australia preserves its position through unshakeable Quality of Life metrics.

---
## Conclusion

This project successfully constructs a multi-layered analytical engine that distills fragmented, heterogeneous macroeconomic data into targeted socio-economic insights. By leveraging advanced data engineering pipelines,incorporating defensive division logic, sequential Common Table Expressions (CTEs), and dynamic window partitions, the dataset provides a rigorous baseline for assessing national performance through the post-COVID inflation crisis.

### Key Takeaways:
* **The Normalization Engine Value:** Standardizing macro indicators using custom Min-Max strategies proved vital for objective comparisons. Without this process, massive scale differences (e.g., trillions of dollars in US GDP vs. single-digit unemployment percentages) would heavily bias composite analysis. 
* **Divergent Recovery Strategies:** The final composite scoring model highlights distinct national variations in economic resilience. While the United States relies heavily on hyper-scale economic output to maintain high asset performance despite inflation shocks, Germany and Japan protect their positions by stabilizing foundational labour markets and public quality-of-life indices.
* **Monetary Policy Proactivity:** Visualizing monetary responses confirms that proactive, early-cycle tightening (as seen in Brazil) is often necessary for stabilization in highly volatile markets, whereas delayed reactive measures (as observed in the Eurozone) can cause inflation pressures to linger over extended periods.

Ultimately, this analysis moves past basic, standalone metrics to evaluate economic health holistically. The project demonstrates a strong ability to translate raw transactional data from public repositories into refined, engineered analytical products capable of driving complex macroeconomic tracking.

## Upcoming Project: Power BI & Power Query Dynamic Visualization

Building upon the backend data engineering established in this project, the next phase focuses on transitioning these SQL datasets into an interactive business intelligence suite using **Power BI** and **Power Query**. 

Rather than relying on static image exports, this upcoming expansion will leverage the same cleaned, unified data architecture to deploy highly dynamic, consumer-facing macro dashboards.
