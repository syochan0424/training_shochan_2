view: basket {
  derived_table: {
    sql:
    SELECT
      a.item_name AS item_name_1,
      b.item_name AS item_name_2,
      fs1.item_code AS item_code_1,
      COUNT(fs1.item_code) AS cooccurrence_count
    FROM
      "TRAINING_SISENSE"."FACT_SALES" fs1
    JOIN
      "TRAINING_SISENSE"."FACT_SALES" fs2
      ON fs1.client_id = fs2.client_id
      AND fs1.sale_date = fs2.sale_date
      AND fs1.item_code != fs2.item_code
      AND fs1.item_code < fs2.item_code
    JOIN
      "TRAINING_SISENSE"."DIMENTION_ITEM" a
      ON fs1.item_code = a.item_code
    JOIN
      "TRAINING_SISENSE"."DIMENTION_ITEM" b
      ON fs2.item_code = b.item_code
    WHERE
      a.item_name = {% parameter selected_item %} -- フィルターで指定された商品名
    GROUP BY
      item_name_1, item_name_2, item_code_1
    ORDER BY
      cooccurrence_count DESC
    limit 44
    ;;
  }

  dimension: item_code {
    type: number
    sql: ${TABLE}.item_code_1 ;;
  }

  dimension: item_name_1 {
    type: string
    sql: ${TABLE}.item_name_1 ;;
  }

  dimension: item_name_2 {
    type: string
    sql: ${TABLE}.item_name_2 ;;
    link: {
      label: "商品ごとフィルター"
      url: "{{_explore._dashboard_url}}?Rfm+Segment=&Item+Category+Medium=&県ごと=&商品名ごと={{value}}&月ごと="
    }
  }



  measure: cooccurrence_count {
    type: sum
    sql: ${TABLE}.cooccurrence_count ;;
    value_format: "#,##0"
  }

  filter: selected_item {
    type: string
    suggest_dimension: item_name_1
  }
}
