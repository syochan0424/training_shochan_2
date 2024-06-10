view: dimention_item {
  sql_table_name: "TRAINING_SISENSE"."DIMENTION_ITEM" ;;

  dimension: brand_name {
    type: string
    sql: ${TABLE}."BRAND_NAME" ;;
  }
  dimension: item_category_code {
    type: number
    sql: ${TABLE}."ITEM_CATEGORY_CODE" ;;
  }
  dimension: item_code {
    type: number
    sql: ${TABLE}."ITEM_CODE" ;;
  }
  dimension: item_name {
    type: string
    sql: ${TABLE}."ITEM_NAME" ;;
  }
  measure: count {
    type: count
    drill_fields: [item_name, brand_name]
  }
}
