{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('items_base') }}
select
    _airbyte_items_hashid,
    {{ json_extract_scalar('AssetAccountRef', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('AssetAccountRef', ['value'], ['value']) }} as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('items_base') }} as table_alias
-- AssetAccountRef at items/AssetAccountRef
where 1 = 1
and AssetAccountRef is not null

