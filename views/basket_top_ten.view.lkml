view: basket_top_ten {

  derived_table: {
    sql:
      WITH ranked_items AS (
        SELECT
          a.item_name AS item_name_1,
          b.item_name AS item_name_2,
          fs1.item_code AS item_code_1,
          COUNT(fs1.item_code) AS cooccurrence_count,
          rank() OVER (ORDER BY COUNT(fs1.item_code) DESC) AS rank,
          COUNT(*) OVER() AS total_count
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
          a.item_name, b.item_name, fs1.item_code
      )
      SELECT
        item_name_1,
        item_name_2,
        item_code_1,
        cooccurrence_count,
        rank,
        total_count,
        CASE
          WHEN rank <= total_count * 0.10 THEN 'Top 10%'
          ELSE 'Others'
        END AS rank_group
      FROM
        ranked_items
      WHERE
        rank <= total_count * 0.10  -- 上位10%に含まれるレコードのみを表示
    ;;
  }

  dimension: item_code_1 {
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

  dimension: rank_group {
    type: string
    sql: ${TABLE}.rank_group ;;
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
