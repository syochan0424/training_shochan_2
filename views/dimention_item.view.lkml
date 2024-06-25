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
  #  link: {
  #    label: "商品ごとフィルター"
  #    url: "https://insightlabpartner.jp.looker.com/dashboards/62?顧客指標={{ _filters['RFM.rfm_segment'] | url_encode }}&商品中分類={{ _filters['dimention_item_category.item_category_medium'] | url_encode }}&県ごと=&商品名ごと={{ value | url_encode }}&月ごと="
  #  }
  }
  measure: count {
    type: count
    drill_fields: [item_name, brand_name]
  }
}
