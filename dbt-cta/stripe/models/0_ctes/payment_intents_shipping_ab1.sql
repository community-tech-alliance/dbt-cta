{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_base') }}
select
    _airbyte_payment_intents_hashid,
    {{ json_extract_scalar('shipping', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('shipping', ['phone'], ['phone']) }} as phone,
    {{ json_extract('table_alias', 'shipping', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('shipping', ['carrier'], ['carrier']) }} as carrier,
    {{ json_extract_scalar('shipping', ['tracking_number'], ['tracking_number']) }} as tracking_number,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_base') }} as table_alias
-- shipping at payment_intents_base/shipping
where
    1 = 1
    and shipping is not null
{{ incremental_clause('_airbyte_emitted_at') }}

