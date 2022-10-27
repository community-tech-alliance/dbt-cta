{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_total_details_breakdown_discounts_ab1') }}
select
    _airbyte_breakdown_hashid,
    cast(amount as {{ dbt_utils.type_bigint() }}) as amount,
    cast(discount as {{ type_json() }}) as discount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_total_details_breakdown_discounts_ab1') }}
-- discounts at checkout_sessions/total_details/breakdown/discounts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

