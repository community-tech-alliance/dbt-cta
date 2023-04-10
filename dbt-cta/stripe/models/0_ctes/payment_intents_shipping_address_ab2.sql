{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_shipping_address_ab1') }}
select
    _airbyte_shipping_hashid,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(line1 as {{ dbt_utils.type_string() }}) as line1,
    cast(line2 as {{ dbt_utils.type_string() }}) as line2,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(postal_code as {{ dbt_utils.type_string() }}) as postal_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_shipping_address_ab1') }}
-- address at payment_intents_base/shipping/address
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

