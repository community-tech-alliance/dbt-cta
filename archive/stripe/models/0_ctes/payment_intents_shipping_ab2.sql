{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_shipping_ab1') }}
select
    _airbyte_payment_intents_hashid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(address as {{ type_json() }}) as address,
    cast(carrier as {{ dbt_utils.type_string() }}) as carrier,
    cast(tracking_number as {{ dbt_utils.type_string() }}) as tracking_number,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_shipping_ab1') }}
-- shipping at payment_intents_base/shipping
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

