{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('estimates_base') }}
{{ unnest_cte(ref('estimates_base'), 'estimates', 'CustomField') }}
select
    _airbyte_estimates_hashid,
    {{ json_extract_scalar(unnested_column_value('CustomField'), ['Type'], ['Type']) }} as Type,
    {{ json_extract_scalar(unnested_column_value('CustomField'), ['DefinitionId'], ['DefinitionId']) }} as DefinitionId,
    {{ json_extract_scalar(unnested_column_value('CustomField'), ['Name'], ['Name']) }} as Name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('estimates_base') }} as table_alias
-- CustomField at estimates/CustomField
{{ cross_join_unnest('estimates', 'CustomField') }}
where 1 = 1
and CustomField is not null

