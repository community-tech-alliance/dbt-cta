{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payments') }}
select
    _airbyte_payments_hashid,
    {{ json_extract('table_alias', 'card_details', ['card'], ['card']) }} as card,
    {{ json_extract_scalar('card_details', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('card_details', ['avs_status'], ['avs_status']) }} as avs_status,
    {{ json_extract_scalar('card_details', ['cvv_status'], ['cvv_status']) }} as cvv_status,
    {{ json_extract_scalar('card_details', ['entry_method'], ['entry_method']) }} as entry_method,
    {{ json_extract('table_alias', 'card_details', ['card_payment_timeline'], ['card_payment_timeline']) }} as card_payment_timeline,
    {{ json_extract_scalar('card_details', ['statement_description'], ['statement_description']) }} as statement_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payments_base') }} as table_alias
-- card_details at payments/card_details
where
    1 = 1
    and card_details is not null
{{ incremental_clause('_airbyte_emitted_at') }}

