{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_transfer_data_ab1') }}
select
    _airbyte_payment_intents_hashid,
    cast(amount as {{ dbt_utils.type_bigint() }}) as amount,
    cast(destination as {{ dbt_utils.type_string() }}) as destination,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_transfer_data_ab1') }}
-- transfer_data at payment_intents_base/transfer_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

