{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('terms_base') }}
select
    _airbyte_terms_hashid,
    {{ json_extract_scalar('MetaData', ['CreateTime'], ['CreateTime']) }} as CreateTime,
    {{ json_extract_scalar('MetaData', ['LastUpdatedTime'], ['LastUpdatedTime']) }} as LastUpdatedTime,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('terms_base') }}
-- MetaData at terms/MetaData
where
    1 = 1
    and MetaData is not null
