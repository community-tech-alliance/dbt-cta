{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('ctas_base') }}
{{ unnest_cte(ref('ctas'), 'ctas', 'shareables') }}
select
    _airbyte_ctas_hashid,
    {{ json_extract_scalar(unnested_column_value('shareables'), ['displayLabel'], ['displayLabel']) }} as displayLabel,
    {{ json_extract_scalar(unnested_column_value('shareables'), ['type'], ['type']) }} as type,
    {{ json_extract_scalar(unnested_column_value('shareables'), ['url'], ['url']) }} as url,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ctas_base') }}
{{ cross_join_unnest('ctas', 'shareables') }}
where
    1 = 1
    and shareables is not null
