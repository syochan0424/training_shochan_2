view: RFM {
  derived_table: {
    sql:
      WITH latest_sales AS (
        SELECT
          client_id,
          MAX(TO_DATE(sale_date, 'YYYY/MM/DD')) AS latest_sale_date,
          COUNT(sale_date) AS frequency,
          SUM(sale_amount) AS total_sales_amount
        FROM "TRAINING_SISENSE"."FACT_SALES"
        GROUP BY client_id
      ),
      recency_calc AS (
        SELECT
          client_id,
          latest_sale_date,
          frequency,
          total_sales_amount,
          DATEDIFF('day', latest_sale_date, TO_DATE('2020-12-31', 'YYYY-MM-DD')) AS recency
        FROM latest_sales
      ),
      ranked_sales AS (
        SELECT
          client_id,
          latest_sale_date,
          frequency,
          total_sales_amount,
          recency,
         CASE
            WHEN DATEDIFF('day', latest_sale_date, TO_DATE('2020-12-31', 'YYYY-MM-DD')) <= 30 THEN 5
            WHEN DATEDIFF('day', latest_sale_date, TO_DATE('2020-12-31', 'YYYY-MM-DD')) <= 60 THEN 4
            WHEN DATEDIFF('day', latest_sale_date, TO_DATE('2020-12-31', 'YYYY-MM-DD')) <= 90 THEN 3
            WHEN DATEDIFF('day', latest_sale_date, TO_DATE('2020-12-31', 'YYYY-MM-DD')) <= 120 THEN 2
            ELSE 1
          END AS recency_rank,
          CASE
            WHEN frequency <= 100 THEN 1
            WHEN frequency <= 400 THEN 2
            WHEN frequency <= 680 THEN 3
            WHEN frequency <= 900 THEN 4
            ELSE 5
          END AS frequency_rank,
          CASE
            WHEN total_sales_amount <= 50000 THEN 1
            WHEN total_sales_amount <= 100000 THEN 2
            WHEN total_sales_amount <= 250000 THEN 3
            WHEN total_sales_amount <= 450000 THEN 4
            ELSE 5
          END AS monetary_rank
        FROM recency_calc
      )
      SELECT
        client_id,
        latest_sale_date,
        frequency,
        total_sales_amount,
        recency,
        recency_rank,
        frequency_rank,
        monetary_rank,
        recency_rank + frequency_rank + monetary_rank AS rfm_score,
        CASE
          WHEN recency_rank + frequency_rank + monetary_rank >= 12 THEN '重要顧客'
          WHEN recency_rank + frequency_rank + monetary_rank >= 8 THEN '潜在顧客'
          WHEN recency_rank + frequency_rank + monetary_rank >= 4 THEN '普通顧客'
          ELSE '休眠顧客'
        END AS rfm_segment
      FROM ranked_sales
    ;;
  }

  dimension: client_id {
    type: number
    primary_key: yes
    sql: ${TABLE}."CLIENT_ID" ;;
  }

  measure: count_client_id {
    type: count_distinct
    sql: ${TABLE}."CLIENT_ID" ;;
  }

  dimension: latest_sale_date {
    type: date
    sql: ${TABLE}."LATEST_SALE_DATE" ;;
  }

  measure: frequency {
    type: sum
    sql: ${TABLE}."FREQUENCY" ;;
  }

  measure: monetary {
    type: sum
    sql: ${TABLE}."TOTAL_SALES_AMOUNT" ;;
  }

  measure: recency {
    type: sum
    sql: ${TABLE}."RECENCY" ;;
  }

  measure: recency_rank {
    type: sum
    sql: ${TABLE}."RECENCY_RANK" ;;
  }

  measure: frequency_rank {
    type: sum
    sql: ${TABLE}."FREQUENCY_RANK" ;;
  }

  measure: monetary_rank {
    type: sum
    sql: ${TABLE}."MONETARY_RANK" ;;
  }

  measure: rfm_score {
    type: sum
    sql: ${TABLE}."RFM_SCORE" ;;
  }

 dimension: rfm_segment {
  type: string
  sql: ${TABLE}."RFM_SEGMENT" ;;
  }
}
