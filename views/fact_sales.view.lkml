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
    type: number
    sql: ${TABLE}."ITEM_CODE" ;;
  }
  dimension: sale_amount {
    type: number
    sql: ${TABLE}."SALE_AMOUNT" ;;
  }

  dimension: sale_date {
    type: date
    sql: TO_DATE(${TABLE}."SALE_DATE", 'YYYY/MM/DD') ;;
  }

  dimension: sale_quantity {
    type: number
    sql: ${TABLE}."SALE_QUANTITY" ;;
  }
  dimension: shop_id {
    type: number
    sql: ${TABLE}."SHOP_ID" ;;
  }

  measure: total_sales_amount {
    type: sum
    sql: ${TABLE}."SALE_AMOUNT" ;;
    value_format: "#,##0;-(#,##0)"
  }

  measure: count_client_id {
    type: count_distinct
    sql: ${client_id} ;;
  }

  measure: count_sale_date {
    type: count_distinct
    sql: ${TABLE}."SALE_DATE";;
  }

  measure: profit {
    type: sum
    sql: ${sale_amount} - ${cost_price} ;;
  }

  dimension: sale_month {
    type: string
    sql: DATE_TRUNC('MONTH', TO_DATE(${TABLE}."SALE_DATE", 'YYYY/MM/DD')) ;;
    description: "月ごとのフィルター用フィールド"
  }

  dimension: sale_year {
    type: string
    sql: DATE_TRUNC('YEAR', TO_DATE(${TABLE}."SALE_DATE", 'YYYY/MM/DD')) ;;
    description: "年ごとのフィルター用フィールド"
  }

 measure: monthly_growth_rate {
  type: number
  sql: (
      (
        SUM(${sale_amount}) -
        LAG(SUM(${sale_amount})) OVER (ORDER BY DATE_TRUNC('MONTH', ${sale_date}))
      ) /
      NULLIF(LAG(SUM(${sale_amount})) OVER (ORDER BY DATE_TRUNC('MONTH', ${sale_date})), 0)
    ) * 100 ;;
  value_format: "#,##0.00%"
  description: "前月比の成長率"
}

measure: yearly_growth_rate {
  type: number
  sql: (
      (
        SUM(${sale_amount}) -
        LAG(SUM(${sale_amount})) OVER (ORDER BY DATE_TRUNC('YEAR', ${sale_date}))
      ) /
      NULLIF(LAG(SUM(${sale_amount})) OVER (ORDER BY DATE_TRUNC('YEAR', ${sale_date})), 0)
    ) * 100 ;;
  value_format: "#,##0.00%"
  description: "前年比の成長率"
}

measure: overall_growth_rate {
  type: number
  sql: (
      (
        SUM(${sale_amount}) -
        FIRST_VALUE(SUM(${sale_amount})) OVER (ORDER BY ${sale_date})
      ) /
      NULLIF(FIRST_VALUE(SUM(${sale_amount})) OVER (ORDER BY ${sale_date}), 0)
    ) * 100 ;;
  value_format: "#,##0.00%"
  description: "全体の成長率"
}

  measure: moving_average_7_days {
    type: number
    sql: AVG(${total_sales_amount}) OVER (ORDER BY ${sale_date} ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) ;;
    value_format: "#,##0"
    description: "7日間の移動平均"
  }

  measure: moving_average_30_days {
    type: number
    sql: AVG(${total_sales_amount}) OVER (ORDER BY ${sale_date} ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) ;;
    value_format: "#,##0"
    description: "30日間の移動平均"
  }
}
