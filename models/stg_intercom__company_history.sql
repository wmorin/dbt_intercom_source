with base as (

    select * 
    from {{ ref('stg_intercom__company_history_tmp') }}

),

fields as (

    select
    /*
    The below macro is used to generate the correct SQL for package staging models. It takes a list of columns 
    that are expected/needed (staging_columns from dbt_salesforce_source/models/tmp/) and compares it with columns 
    in the source (source_columns from dbt_salesforce_source/macros/).
    For more information refer to our dbt_fivetran_utils documentation (https://github.com/fivetran/dbt_fivetran_utils.git).
    */

        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_intercom__company_history_tmp')),
                staging_columns=get_company_history_columns()
            )
        }}

        --The below script allows for pass through columns.
        {% if var('company_history_pass_through_columns') %}
        ,
        {{ var('company_history_pass_through_columns') | join (", ")}}

        {% endif %}    
    from base
),

final as (
    
    select 
        id as company_id,
        name as company_name,
        website,
        industry,
        created_at,
        updated_at,
        user_count,
        session_count,
        monthly_spend,
        plan_id,
        plan_name,
        _fivetran_deleted

        --The below script allows for pass through columns.
        {% if var('company_history_pass_through_columns') %}
        ,
        {{ var('company_history_pass_through_columns') | join (", ")}}

        {% endif %}
    from fields
)

select * 
from final
where not coalesce(_fivetran_deleted, false)
