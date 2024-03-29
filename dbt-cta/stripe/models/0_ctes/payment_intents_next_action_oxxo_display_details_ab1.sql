{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_next_action_base') }}
select
    _airbyte_next_action_hashid,
    {{ json_extract_scalar('oxxo_display_details', ['number'], ['number']) }} as number,
    {{ json_extract_scalar('oxxo_display_details', ['expires_after'], ['expires_after']) }} as expires_after,
    {{ json_extract_scalar('oxxo_display_details', ['hosted_voucher_url'], ['hosted_voucher_url']) }} as hosted_voucher_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_next_action_base') }}
-- oxxo_display_details at payment_intents_base/next_action/oxxo_display_details
where
    1 = 1
    and oxxo_display_details is not null
{{ incremental_clause('_airbyte_emitted_at') }}

