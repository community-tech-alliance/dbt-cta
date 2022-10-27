{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents') }}
select
    _airbyte_payment_intents_hashid,
    {{ json_extract_scalar('transfer_data', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('transfer_data', ['destination'], ['destination']) }} as destination,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents') }} as table_alias
-- transfer_data at payment_intents/transfer_data
where 1 = 1
and transfer_data is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

