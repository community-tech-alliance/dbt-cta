{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_denominations_people') }}
select
    {{ json_extract_scalar('_airbyte_data', ['denomination_id'], ['denomination_id']) }} as denomination_id,
    {{ json_extract_scalar('_airbyte_data', ['person_id'], ['person_id']) }} as person_id,
    {{ json_extract_scalar('_airbyte_data', ['denominmemberable_type'], ['denominmemberable_type']) }} as denominmemberable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_denominations_people') }}
-- denominations_people
where 1 = 1
