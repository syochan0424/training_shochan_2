view: basket_top_ten {
  derived_table: {
    sql:
      WITH ranked_items AS (
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
          a.item_name = {% parameter selected_item %}
        GROUP BY
          a.item_name, b.item_name, fs1.item_code
      ),
      ranked_with_total AS (
        SELECT
          item_name_1,
          item_name_2,
          item_code_1,
          cooccurrence_count,
          COUNT(*) OVER () AS total_items,
          ROW_NUMBER() OVER (ORDER BY cooccurrence_count DESC) AS rank
        FROM ranked_items
      )
      SELECT
        item_name_1,
        item_name_2,
        item_code_1,
        cooccurrence_count,
        total_items,
        CASE
          WHEN rank <= total_items / 10 THEN 'Top 10%'
          ELSE 'Others'
        END AS top_10_percent_flag
      FROM
        ranked_with_total
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
  }

  dimension: top_10_percent_flag {
    type: string
    sql: ${TABLE}.top_10_percent_flag ;;
    description: "トップ10%に入っている共起アイテムを示すフラグです。"
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
