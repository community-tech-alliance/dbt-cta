{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payments_card_details') }}
select
    _airbyte_card_details_hashid,
    {{ json_extract_scalar('card_payment_timeline', ['voided_at'], ['voided_at']) }} as voided_at,
    {{ json_extract_scalar('card_payment_timeline', ['captured_at'], ['captured_at']) }} as captured_at,
    {{ json_extract_scalar('card_payment_timeline', ['authorized_at'], ['authorized_at']) }} as authorized_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payments_card_details_base') }}
-- card_payment_timeline at payments/card_details/card_payment_timeline
where
    1 = 1
    and card_payment_timeline is not null
{{ incremental_clause('_airbyte_emitted_at') }}

