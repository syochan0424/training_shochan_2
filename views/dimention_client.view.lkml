view: dimention_client {
  sql_table_name: "TRAINING_SISENSE"."DIMENTION_CLIENT" ;;

  dimension: birthday {
    type: string
    sql: ${TABLE}."BIRTHDAY" ;;
  }
  dimension: client_id {
    type: number
    sql: ${TABLE}."CLIENT_ID" ;;
  }
  dimension: client_name {
    type: string
    sql: ${TABLE}."CLIENT_NAME" ;;
  }
  dimension: client_post_code {
    type: string
    sql: ${TABLE}."CLIENT_POST_CODE" ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}."GENDER" ;;
  }
  dimension: iclient_prefecture {
    type: string
    sql: ${TABLE}."ICLIENT_PREFECTURE" ;;
  }
  measure: count {
    type: count
    drill_fields: [client_name]
  }
}
