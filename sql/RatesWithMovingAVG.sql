CREATE OR REPLACE VIEW `nbp_exchange_rates.rates_with_moving_avg` AS
SELECT
  effectiveDate,
  currency,
  mid AS rate,
  AVG(mid) OVER (
    PARTITION BY currency
    ORDER BY effectiveDate
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
  ) AS avg_7d,
  AVG(mid) OVER (
    PARTITION BY currency
    ORDER BY effectiveDate
    ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
  ) AS avg_30d
FROM `nbp_exchange_rates.exchange_rates_data`
ORDER BY currency, effectiveDate;