CREATE OR REPLACE VIEW `nbp_exchange_rates.rates_monthly_summary` AS
SELECT
  currency,
  FORMAT_DATE('%Y-%m', effectiveDate) AS year_month,
  ROUND(AVG(mid), 4) AS avg_rate,
  ROUND(MIN(mid), 4) AS min_rate,
  ROUND(MAX(mid), 4) AS max_rate,
  ROUND(MAX(mid) - MIN(mid), 4) AS range_rate,
  ROUND((MAX(mid) - MIN(mid)) / AVG(mid) * 100, 2) AS range_pct
FROM `nbp_exchange_rates.exchange_rates_data`
GROUP BY currency, year_month
ORDER BY currency, year_month;