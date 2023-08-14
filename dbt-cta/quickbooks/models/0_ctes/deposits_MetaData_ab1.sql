{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('deposits') }}
select
    _airbyte_deposits_hashid,
    {{ json_extract_scalar('MetaData', ['CreateTime'], ['CreateTime']) }} as CreateTime,
    {{ json_extract_scalar('MetaData', ['LastUpdatedTime'], ['LastUpdatedTime']) }} as LastUpdatedTime,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('deposits') }} as table_alias
-- MetaData at deposits/MetaData
where 1 = 1
and MetaData is not null

