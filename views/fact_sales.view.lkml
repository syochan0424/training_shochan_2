view: fact_sales {
  sql_table_name: "TRAINING_SISENSE"."FACT_SALES" ;;
  dimension: client_id {
    type: number
    sql: ${TABLE}."CLIENT_ID" ;;
  }
  dimension: cost_price {
    type: number
    sql: ${TABLE}."COST_PRICE" ;;
  }
  dimension: item_code {
    type: string
    sql: ${TABLE}."ITEM_CODE" ;;
  }
  dimension: sale_amount {
    type: number
    sql: ${TABLE}."SALE_AMOUNT" ;;
  }

  dimension: sale_date {
    type: date
    sql: TO_DATE(${TABLE}."SALE_DATE", 'YYYY/MM/DD') ;;
  }

  dimension: sale_quantity {
    type: number
    sql: ${TABLE}."SALE_QUANTITY" ;;
  }
  dimension: shop_id {
    type: number
    sql: ${TABLE}."SHOP_ID" ;;
  }

  measure: total_sales_amount {
    type: sum
    sql: ${TABLE}."SALE_AMOUNT" ;;
  }

  measure: count_client_id {
    type: count_distinct
    sql: ${client_id} ;;
  }

  measure: count_sale_date {
    type: count_distinct
    sql: ${TABLE}."SALE_DATE";;
  }

  measure: profit {
    type: sum
    sql: ${sale_amount} - ${cost_price} ;;
  }

  measure: count_sales {
    type: count
  }

  measure: recency {
    type: number
    sql: DATEDIFF('day', ${TABLE}."SALE_DATE", (SELECT MAX(TO_DATE(SALE_DATE, 'YYYY/MM/DD')) FROM "TRAINING_SISENSE"."FACT_SALES" GROUP BY ${TABLE}."CLIENT_ID")) ;;
    drill_fields: [client_id, sale_date]
  }

  measure: frequency {
    type: count_distinct
    sql: ${TABLE}."SALE_DATE" ;;
  }

  measure: monetary {
    type: sum
    sql: ${TABLE}."SALE_AMOUNT" ;;
  }

  measure: rfm_score {
    type: number
    sql: (${recency} * 0.4) + (${frequency} * 0.4) + (${monetary} * 0.2) ;;
  }

  measure: rfm_segment {
    type: string
    sql: CASE
           WHEN ${rfm_score} >= 9 THEN '重要顧客'
           WHEN ${rfm_score} >= 6 THEN '潜在顧客'
           WHEN ${rfm_score} >= 3 THEN '普通顧客'
           ELSE '休眠顧客'
         END ;;
  }

  dimension: sale_month {
    type: string
    sql: DATE_TRUNC('MONTH', TO_DATE(${TABLE}."SALE_DATE", 'YYYY/MM/DD')) ;;
    description: "月ごとのフィルター用フィールド"
  }

}
