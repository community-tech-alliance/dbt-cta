{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('purchases_base') }}
select
    _airbyte_purchases_hashid,
    {{ json_extract_scalar('EntityRef', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('EntityRef', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('EntityRef', ['value'], ['value']) }} as value,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchases_base') }}
-- EntityRef at purchases/EntityRef
where
    1 = 1
    and EntityRef is not null
