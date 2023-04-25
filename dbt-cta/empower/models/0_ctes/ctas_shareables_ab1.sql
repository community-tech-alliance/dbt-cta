{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('ctas') }}
{{ unnest_cte(ref('ctas'), 'ctas', 'shareables') }}
select
    _airbyte_ctas_hashid,
    {{ json_extract_scalar(unnested_column_value('shareables'), ['displayLabel'], ['displayLabel']) }} as displayLabel,
    {{ json_extract_scalar(unnested_column_value('shareables'), ['type'], ['type']) }} as type,
    {{ json_extract_scalar(unnested_column_value('shareables'), ['url'], ['url']) }} as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ctas') }} as table_alias
-- shareables at ctas/shareables
{{ cross_join_unnest('ctas', 'shareables') }}
where 1 = 1
and shareables is not null

