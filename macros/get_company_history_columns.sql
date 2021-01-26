{% macro get_company_history_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "created_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "industry", "datatype": dbt_utils.type_int()},
    {"name": "monthly_spend", "datatype": dbt_utils.type_int()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "plan_id", "datatype": dbt_utils.type_int()},
    {"name": "plan_name", "datatype": dbt_utils.type_int()},
    {"name": "session_count", "datatype": dbt_utils.type_int()},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "user_count", "datatype": dbt_utils.type_int()},
    {"name": "website", "datatype": dbt_utils.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
