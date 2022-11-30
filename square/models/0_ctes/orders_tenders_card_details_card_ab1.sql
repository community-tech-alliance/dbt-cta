{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders_tenders_card_details') }}
select
    _airbyte_card_details_hashid,
    {{ json_extract_scalar('card', ['last_4'], ['last_4']) }} as last_4,
    {{ json_extract_scalar('card', ['card_brand'], ['card_brand']) }} as card_brand,
    {{ json_extract_scalar('card', ['fingerprint'], ['fingerprint']) }} as fingerprint,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_tenders_card_details') }} as table_alias
-- card at orders/tenders/card_details/card
where 1 = 1
and card is not null

