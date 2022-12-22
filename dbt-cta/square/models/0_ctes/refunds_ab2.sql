{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('refunds_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(reason as {{ dbt_utils.type_string() }}) as reason,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(order_id as {{ dbt_utils.type_string() }}) as order_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(payment_id as {{ dbt_utils.type_string() }}) as payment_id,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(location_id as {{ dbt_utils.type_string() }}) as location_id,
    cast(amount_money as {{ type_json() }}) as amount_money,
    processing_fee,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('refunds_ab1') }}
-- refunds
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

