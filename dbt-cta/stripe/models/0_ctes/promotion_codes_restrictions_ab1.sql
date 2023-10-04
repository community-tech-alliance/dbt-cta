{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('promotion_codes_base') }}
select
    _airbyte_promotion_codes_hashid,
    {{ json_extract_scalar('restrictions', ['minimum_amount'], ['minimum_amount']) }} as minimum_amount,
    {{ json_extract_scalar('restrictions', ['first_time_transaction'], ['first_time_transaction']) }} as first_time_transaction,
    {{ json_extract_scalar('restrictions', ['minimum_amount_currency'], ['minimum_amount_currency']) }} as minimum_amount_currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('promotion_codes_base') }}
-- restrictions at promotion_codes_base/restrictions
where
    1 = 1
    and restrictions is not null
{{ incremental_clause('_airbyte_emitted_at') }}

