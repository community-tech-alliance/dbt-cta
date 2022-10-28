{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_next_action_oxxo_display_details_ab1') }}
select
    _airbyte_next_action_hashid,
    cast(number as {{ dbt_utils.type_string() }}) as number,
    cast(expires_after as {{ dbt_utils.type_bigint() }}) as expires_after,
    cast(hosted_voucher_url as {{ dbt_utils.type_string() }}) as hosted_voucher_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_next_action_oxxo_display_details_ab1') }}
-- oxxo_display_details at payment_intents/next_action/oxxo_display_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

