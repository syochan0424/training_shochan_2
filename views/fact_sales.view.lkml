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
    type: string
    sql: ${TABLE}."SALE_DATE" ;;
  }
  dimension: sale_quantity {
    type: number
    sql: ${TABLE}."SALE_QUANTITY" ;;
  }
  dimension: shop_id {
    type: number
    sql: ${TABLE}."SHOP_ID" ;;
  }
  measure: count {
    type: count
  }
}
