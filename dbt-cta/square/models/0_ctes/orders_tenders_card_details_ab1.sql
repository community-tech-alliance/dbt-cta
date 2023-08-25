{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_tenders') }}
select
    _airbyte_tenders_hashid,
    {{ json_extract('table_alias', 'card_details', ['card'], ['card']) }} as card,
    {{ json_extract_scalar('card_details', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('card_details', ['entry_method'], ['entry_method']) }} as entry_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_tenders_base') }} as table_alias
-- card_details at orders/tenders/card_details
where
    1 = 1
    and card_details is not null
