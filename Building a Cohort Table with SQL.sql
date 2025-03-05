with source as (
--query for paid invoices

--please add code for number_purchase on your paid invoices query:
    --row_number() OVER (PARTITION BY client_id ORDER BY paid_at) as number_purchase
),

cohort AS (
  SELECT
    MAKE_DATE(EXTRACT(YEAR FROM paid_at)::INTEGER, EXTRACT(MONTH FROM paid_at)::INTEGER, 1) AS cohort_month,
    client_id
  FROM source s1
  WHERE
    s1.paid_at = (
      SELECT MIN(s2.paid_at)
      FROM source s2
      WHERE s2.client_id = s1.client_id
    )
    AND MAKE_DATE(EXTRACT(YEAR FROM s1.paid_at)::INTEGER, EXTRACT(MONTH FROM s1.paid_at)::INTEGER, 1) >= MAKE_DATE(2023, 1, 1) --setup start date 
    AND MAKE_DATE(EXTRACT(YEAR FROM s1.paid_at)::INTEGER, EXTRACT(MONTH FROM s1.paid_at)::INTEGER, 1) < MAKE_DATE(EXTRACT(YEAR FROM CURRENT_DATE)::INTEGER, EXTRACT(MONTH FROM CURRENT_DATE)::INTEGER, 1) 
  GROUP BY MAKE_DATE(EXTRACT(YEAR FROM s1.paid_at)::INTEGER, EXTRACT(MONTH FROM s1.paid_at)::INTEGER, 1), client_id
),

retention AS (
  SELECT
    cohort.cohort_month,
    COUNT(DISTINCT CASE WHEN s.paid_at >= cohort.cohort_month AND s.paid_at <= MAKE_DATE(EXTRACT(YEAR FROM cohort.cohort_month)::INTEGER, 12, 31) AND s.number_purchase = 1 THEN cohort.client_id END) AS "purchase_1st",
    COUNT(DISTINCT CASE WHEN s.paid_at >= cohort.cohort_month AND s.paid_at <= MAKE_DATE(EXTRACT(YEAR FROM cohort.cohort_month)::INTEGER, 12, 31) AND s.number_purchase = 2 THEN cohort.client_id END) AS "purchase_2nd",
    COUNT(DISTINCT CASE WHEN s.paid_at >= cohort.cohort_month AND s.paid_at <= MAKE_DATE(EXTRACT(YEAR FROM cohort.cohort_month)::INTEGER, 12, 31) AND s.number_purchase = 3 THEN cohort.client_id END) AS "purchase_3rd",
    COUNT(DISTINCT CASE WHEN s.paid_at >= cohort.cohort_month AND s.paid_at <= MAKE_DATE(EXTRACT(YEAR FROM cohort.cohort_month)::INTEGER, 12, 31) AND s.number_purchase = 4 THEN cohort.client_id END) AS "purchase_4th",
    COUNT(DISTINCT CASE WHEN s.paid_at >= cohort.cohort_month AND s.paid_at <= MAKE_DATE(EXTRACT(YEAR FROM cohort.cohort_month)::INTEGER, 12, 31) AND s.number_purchase = 5 THEN cohort.client_id END) AS "purchase_5th",
    COUNT(DISTINCT CASE WHEN s.paid_at >= cohort.cohort_month AND s.paid_at <= MAKE_DATE(EXTRACT(YEAR FROM cohort.cohort_month)::INTEGER, 12, 31) AND s.number_purchase = 6 THEN cohort.client_id END) AS "purchase_6th",
    COUNT(DISTINCT CASE WHEN s.paid_at >= cohort.cohort_month AND s.paid_at <= MAKE_DATE(EXTRACT(YEAR FROM cohort.cohort_month)::INTEGER, 12, 31) AND s.number_purchase = 7 THEN cohort.client_id END) AS "purchase_7th",
    COUNT(DISTINCT CASE WHEN s.paid_at >= cohort.cohort_month AND s.paid_at <= MAKE_DATE(EXTRACT(YEAR FROM cohort.cohort_month)::INTEGER, 12, 31) AND s.number_purchase = 8 THEN cohort.client_id END) AS "purchase_8th",
    COUNT(DISTINCT CASE WHEN s.paid_at >= cohort.cohort_month AND s.paid_at <= MAKE_DATE(EXTRACT(YEAR FROM cohort.cohort_month)::INTEGER, 12, 31) AND s.number_purchase = 9 THEN cohort.client_id END) AS "purchase_9th",
    COUNT(DISTINCT CASE WHEN s.paid_at >= cohort.cohort_month AND s.paid_at <= MAKE_DATE(EXTRACT(YEAR FROM cohort.cohort_month)::INTEGER, 12, 31) AND s.number_purchase = 10 THEN cohort.client_id END) AS "purchase_10th",
    COUNT(DISTINCT CASE WHEN s.paid_at >= cohort.cohort_month AND s.paid_at <= MAKE_DATE(EXTRACT(YEAR FROM cohort.cohort_month)::INTEGER, 12, 31) AND s.number_purchase = 11 THEN cohort.client_id END) AS "purchase_11th",
    COUNT(DISTINCT CASE WHEN s.paid_at >= cohort.cohort_month AND s.paid_at <= MAKE_DATE(EXTRACT(YEAR FROM cohort.cohort_month)::INTEGER, 12, 31) AND s.number_purchase = 12 THEN cohort.client_id END) AS "purchase_12th",
    COUNT(DISTINCT CASE WHEN s.paid_at >= cohort.cohort_month AND s.paid_at <= MAKE_DATE(EXTRACT(YEAR FROM cohort.cohort_month)::INTEGER, 12, 31) AND s.number_purchase >= 13 THEN cohort.client_id END) AS "purchase_13th_up"
  FROM source s
  JOIN cohort ON cohort.client_id = s.client_id
  GROUP BY cohort.cohort_month
)

select 
    cohort_month,
    purchase_1st,
    purchase_2nd,
    purchase_3rd,
    purchase_4th,
    purchase_5th,
    purchase_6th,
    purchase_7th,
    purchase_8th,
    purchase_9th,
    purchase_10th,
    purchase_11th,
    purchase_12th,
    purchase_13th_up
from 
    retention
order by 
    cohort_month