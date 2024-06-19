view: decile {
  derived_table: {
    sql:
      WITH customer_sales AS (
        SELECT
          client_id,
          SUM(sale_amount) AS total_sales
        FROM
          "TRAINING_SISENSE"."FACT_SALES"
        GROUP BY
          client_id
      ),
      ranked_customers AS (
        SELECT
          client_id,
          total_sales,
          NTILE(10) OVER (ORDER BY total_sales DESC) AS decile
        FROM
          customer_sales
      )
      SELECT
        client_id,
        total_sales,
        decile
      FROM
        ranked_customers
    ;;
  }

  dimension: client_id {
    type: number
    sql: ${TABLE}.client_id ;;
  }

  measure: total_sales {
    type: sum
    sql: ${TABLE}.total_sales ;;
    value_format: "#,##0"
  }

  dimension: decile {
    type: number
    sql: ${TABLE}.decile ;;
  }
}
