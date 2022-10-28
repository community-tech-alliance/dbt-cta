{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_total_details_ab1') }}
select
    _airbyte_checkout_sessions_hashid,
    cast(breakdown as {{ type_json() }}) as breakdown,
    cast(amount_tax as {{ dbt_utils.type_bigint() }}) as amount_tax,
    cast(amount_discount as {{ dbt_utils.type_bigint() }}) as amount_discount,
    cast(amount_shipping as {{ dbt_utils.type_bigint() }}) as amount_shipping,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_total_details_ab1') }}
-- total_details at checkout_sessions/total_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

