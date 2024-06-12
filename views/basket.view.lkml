view: basket {
  sql_table_name: "TRAINING_SISENSE"."FACT_SALES" ;;

  dimension: client_id {
    type: string
    sql: ${TABLE}."CLIENT_ID" ;;
    drill_fields: [client_id, item_code]
  }

  dimension: item_code {
    type: string
    sql: ${TABLE}."ITEM_CODE" ;;
    drill_fields: [client_id, item_code]
  }

  dimension: purchase_date {
    type: date
    sql: TO_DATE(${TABLE}."SALE_DATE", 'YYYY/MM/DD') ;;
  }

  measure: purchase_count {
    type: count_distinct
    sql: ${TABLE}."CLIENT_ID";;
  }

  measure: sum_amount {
    type: sum
    sql: ${TABLE}."SALE_AMOUNT" ;;
  }
}
