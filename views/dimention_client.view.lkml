view: dimention_client {
  sql_table_name: "TRAINING_SISENSE"."DIMENTION_CLIENT" ;;

  dimension: birthday {
    type: string
    sql: ${TABLE}.birthday ;;
  }

  dimension: parsed_birthday {
    type: date
    sql: TO_DATE(${TABLE}.birthday, 'YYYY/MM/DD') ;;
    hidden: yes
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
    link: {
      label: "View Details"
      url: "{{_explore._dashboard_url}}?Rfm+Segment=&Item+Category+Medium=&県ごと={{value}}&商品名ごと=&月ごと="
    }
  }

  dimension: age {
    type: number
    sql: DATEDIFF(year, TO_DATE(${TABLE}.birthday, 'YYYY/MM/DD'), CURRENT_DATE()) ;;
  }

  dimension: age_group {
    type: string
    sql: CONCAT(FLOOR(DATEDIFF(year, TO_DATE(${TABLE}.birthday, 'YYYY/MM/DD'), CURRENT_DATE()) / 10) * 10, '代') ;;
  }

  measure: count {
    type: count
    drill_fields: [client_name]
  }
}
