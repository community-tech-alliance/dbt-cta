{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payments_card_details') }}
select
    _airbyte_card_details_hashid,
    {{ json_extract_scalar('card', ['bin'], ['bin']) }} as bin,
    {{ json_extract_scalar('card', ['last_4'], ['last_4']) }} as last_4,
    {{ json_extract_scalar('card', ['exp_year'], ['exp_year']) }} as exp_year,
    {{ json_extract_scalar('card', ['card_type'], ['card_type']) }} as card_type,
    {{ json_extract_scalar('card', ['exp_month'], ['exp_month']) }} as exp_month,
    {{ json_extract_scalar('card', ['card_brand'], ['card_brand']) }} as card_brand,
    {{ json_extract_scalar('card', ['fingerprint'], ['fingerprint']) }} as fingerprint,
    {{ json_extract_scalar('card', ['prepaid_type'], ['prepaid_type']) }} as prepaid_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payments_card_details_base') }} as table_alias
-- card at payments/card_details/card
where 1 = 1
and card is not null
{{ incremental_clause('_airbyte_emitted_at') }}

