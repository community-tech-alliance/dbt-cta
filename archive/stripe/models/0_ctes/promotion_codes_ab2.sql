{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('promotion_codes_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(code as {{ dbt_utils.type_string() }}) as code,
    {{ cast_to_boolean('active') }} as active,
    cast(coupon as {{ type_json() }}) as coupon,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(customer as {{ dbt_utils.type_string() }}) as customer,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(expires_at as {{ dbt_utils.type_bigint() }}) as expires_at,
    cast(restrictions as {{ type_json() }}) as restrictions,
    cast(max_redemptions as {{ dbt_utils.type_bigint() }}) as max_redemptions,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('promotion_codes_ab1') }}
-- promotion_codes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

