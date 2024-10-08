{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('bills_base') }}
select
    _airbyte_bills_hashid,
    {{ json_extract_scalar('APAccountRef', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('APAccountRef', ['value'], ['value']) }} as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('bills_base') }}
-- APAccountRef at bills/APAccountRef
where
    1 = 1
    and APAccountRef is not null
