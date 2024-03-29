{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_source_owner_base') }}
select
    _airbyte_owner_hashid,
    {{ json_extract_scalar('address', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('address', ['line1'], ['line1']) }} as line1,
    {{ json_extract_scalar('address', ['line2'], ['line2']) }} as line2,
    {{ json_extract_scalar('address', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('address', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('address', ['postal_code'], ['postal_code']) }} as postal_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_source_owner_base') }}
-- address at charges_base/source/owner/address
where
    1 = 1
    and address is not null
{{ incremental_clause('_airbyte_emitted_at') }}

