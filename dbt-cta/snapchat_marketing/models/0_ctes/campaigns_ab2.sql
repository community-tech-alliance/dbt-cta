{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(buy_model as {{ dbt_utils.type_string() }}) as buy_model,
    cast(objective as {{ dbt_utils.type_string() }}) as objective,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(start_time as {{ dbt_utils.type_string() }}) as start_time,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(ad_account_id as {{ dbt_utils.type_string() }}) as ad_account_id,
    delivery_status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_ab1') }}
-- campaigns
where 1 = 1
