{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_next_action_boleto_display_details_ab1') }}
select
    _airbyte_next_action_hashid,
    cast(pdf as {{ dbt_utils.type_string() }}) as pdf,
    cast(number as {{ dbt_utils.type_string() }}) as number,
    cast(expires_at as {{ dbt_utils.type_bigint() }}) as expires_at,
    cast(hosted_voucher_url as {{ dbt_utils.type_string() }}) as hosted_voucher_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_next_action_boleto_display_details_ab1') }}
-- boleto_display_details at payment_intents_base/next_action/boleto_display_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

