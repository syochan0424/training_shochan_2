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
      label: "県ごとフィルター"
      url: "https://insightlabpartner.jp.looker.com/dashboards/62?顧客指標={{ _filters['RFM.rfm_segment'] | url_encode }}&商品中分類={{ _filters['dimention_item_category.item_category_medium'] | url_encode }}&県ごと={{ value | url_encode }}&商品名ごと={{ dimention_item.item_name | url_encode }}&月ごと={{ _filters['fact_sales.sale_month'] | url_encode }}"
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
