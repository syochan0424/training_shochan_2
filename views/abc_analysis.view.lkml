view: abc_analysis {
  derived_table: {
    sql:
      SELECT
        item_code,
        total_sales_amount,
        RANK() OVER (ORDER BY total_sales_amount DESC) AS sales_rank
      FROM (
        SELECT
          item_code,
          SUM(sale_amount) AS total_sales_amount
        FROM "TRAINING_SISENSE"."FACT_SALES"
        GROUP BY item_code
      ) subquery
    ;;
  }

  dimension: item_code {
    type: string
    primary_key: yes
    sql: ${TABLE}.item_code ;;
  }

  measure: total_sales_amount {
    type: sum
    sql: ${TABLE}.total_sales_amount ;;
  }

  dimension: sales_rank {
    type: number
    sql: ${TABLE}.sales_rank ;;
  }

  dimension: abc_group {
    type: string
    sql: CASE WHEN ${sales_rank} <= 0.2 * (SELECT COUNT(*) FROM ${TABLE}) THEN 'A'
              WHEN ${sales_rank} <= 0.7 * (SELECT COUNT(*) FROM ${TABLE}) THEN 'B'
              ELSE 'C' END ;;
  }
}
