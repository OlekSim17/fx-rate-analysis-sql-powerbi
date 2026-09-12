CREATE OR REPLACE VIEW `nbp_exchange_rates.rates_daily_change` AS
SELECT
  effectiveDate,
  currency,
  mid AS rate,
  LAG(mid) OVER (PARTITION BY currency ORDER BY effectiveDate) AS prev_rate,
  ROUND(
    (mid - LAG(mid) OVER (PARTITION BY currency ORDER BY effectiveDate))
    / LAG(mid) OVER (PARTITION BY currency ORDER BY effectiveDate) * 100,
    3
  ) AS daily_change_pct
FROM `nbp_exchange_rates.exchange_rates_data`
ORDER BY currency, effectiveDate;