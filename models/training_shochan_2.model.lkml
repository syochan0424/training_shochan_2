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

explore: fact_sales {}

