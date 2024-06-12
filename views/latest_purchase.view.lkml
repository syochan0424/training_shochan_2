view: latest_purchase {
  derived_table: {
    sql:
      SELECT
        CLIENT_ID,
        MAX(TO_DATE(SALE_DATE, 'YYYY/MM/DD')) AS LATEST_SALE_DATE
      FROM "TRAINING_SISENSE"."FACT_SALES"
      GROUP BY CLIENT_ID
    ;;
  }

  dimension: client_id {
    type: number
    sql: ${TABLE}."CLIENT_ID" ;;
  }

  dimension: latest_sale_date {
    type: date
    sql: ${TABLE}."LATEST_SALE_DATE" ;;
  }

  measure: recency {
    type: number
    sql: DATEDIFF('day',MAX(${fact_sales.sale_date}) , ${latest_purchase.latest_sale_date}) ;;

  }

}
