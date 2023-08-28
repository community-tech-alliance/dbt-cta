{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_base') }}
select
    _airbyte_payment_intents_hashid,
    {{ json_extract_scalar('charges', ['url'], ['url']) }} as url,
    {{ json_extract_array('charges', ['data'], ['data']) }} as data,
    {{ json_extract_scalar('charges', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('charges', ['has_more'], ['has_more']) }} as has_more,
    {{ json_extract_scalar('charges', ['total_count'], ['total_count']) }} as total_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_base') }}
-- charges at payment_intents_base/charges
where
    1 = 1
    and charges is not null
{{ incremental_clause('_airbyte_emitted_at') }}

