view: dimention_shop {
  sql_table_name: "TRAINING_SISENSE"."DIMENTION_SHOP" ;;

  dimension: location_id {
    type: number
    sql: ${TABLE}."LOCATION_ID" ;;
  }
  dimension: shop_id {
    type: number
    sql: ${TABLE}."SHOP_ID" ;;
  }
  dimension: shop_name {
    type: string
    sql: ${TABLE}."SHOP_NAME" ;;
  }
  dimension: shop_type {
    type: string
    sql: ${TABLE}."SHOP_TYPE" ;;
  }
  measure: count {
    type: count
    drill_fields: [shop_name]
  }
}
