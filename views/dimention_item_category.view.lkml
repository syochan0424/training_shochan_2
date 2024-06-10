view: dimention_item_category {
  sql_table_name: "TRAINING_SISENSE"."DIMENTION_ITEM_CATEGORY" ;;

  dimension: item_category_code {
    type: number
    sql: ${TABLE}."ITEM_CATEGORY_CODE" ;;
  }
  dimension: item_category_large {
    type: string
    sql: ${TABLE}."ITEM_CATEGORY_LARGE" ;;
  }
  dimension: item_category_medium {
    type: string
    sql: ${TABLE}."ITEM_CATEGORY_MEDIUM" ;;
  }
  dimension: item_category_small {
    type: string
    sql: ${TABLE}."ITEM_CATEGORY_SMALL" ;;
  }
  measure: count {
    type: count
  }
}
