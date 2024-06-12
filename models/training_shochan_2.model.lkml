connection: "snowflake_traning"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: training_shochan_2_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: training_shochan_2_default_datagroup

explore: dimention_client {}

explore: dimention_item {}

explore: dimention_item_category {}

explore: dimention_location {}

explore: dimention_shop {}

explore: abc_analysis {}

explore: basket {}

explore: fact_sales {
  join: dimention_client {
    type: left_outer
    sql_on: ${fact_sales.client_id} = ${dimention_client.client_id} ;;
    relationship: many_to_one
  }

  join: dimention_item {
    type: left_outer
    sql_on: ${fact_sales.item_code} = ${dimention_item.item_code} ;;
    relationship: many_to_one
  }

  join: dimention_item_category {
    type: left_outer
    sql_on: ${dimention_item.item_category_code} = ${dimention_item_category.item_category_code} ;;
    relationship: many_to_one
  }

  join: dimention_shop {
    type: left_outer
    sql_on: ${fact_sales.shop_id} = ${dimention_shop.shop_id} ;;
    relationship: many_to_one
  }

  join: dimention_location {
    type: left_outer
    sql_on: ${dimention_shop.location_id} = ${dimention_location.location_id} ;;
    relationship: many_to_one
  }

  join: latest_purchase {
    sql_on: ${fact_sales.client_id} = ${latest_purchase.client_id} ;;
    relationship: many_to_one
  }

  join: abc_analysis {
    type: left_outer
    sql_on: ${fact_sales.item_code} = ${abc_analysis.item_code} ;;
    relationship: many_to_one
  }

  join: basket {
    type: left_outer
    sql_on: ${fact_sales.item_code} = ${basket.item_code} ;;
    relationship: many_to_one
  }

}
