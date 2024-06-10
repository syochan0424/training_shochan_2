view: dimention_location {
  sql_table_name: "TRAINING_SISENSE"."DIMENTION_LOCATION" ;;

  dimension: location_id {
    type: number
    sql: ${TABLE}."LOCATION_ID" ;;
  }
  dimension: sale_area {
    type: string
    sql: ${TABLE}."SALE_AREA" ;;
  }
  dimension: sale_city {
    type: string
    sql: ${TABLE}."SALE_CITY" ;;
  }
  dimension: sale_district {
    type: string
    sql: ${TABLE}."SALE_DISTRICT" ;;
  }
  dimension: sale_district_id {
    type: number
    sql: ${TABLE}."SALE_DISTRICT_ID" ;;
  }
  dimension: sale_prefecture {
    type: string
    sql: ${TABLE}."SALE_PREFECTURE" ;;
  }
  dimension: sale_region {
    type: string
    sql: ${TABLE}."SALE_REGION" ;;
  }
  measure: count {
    type: count
  }
}
