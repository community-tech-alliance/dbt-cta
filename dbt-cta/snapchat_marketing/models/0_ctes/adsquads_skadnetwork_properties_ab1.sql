{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('adsquads_base') }}
select
    id as ad_squad_id,
    {{ json_extract_scalar('skadnetwork_properties', ['status'], ['status']) }} as status,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adsquads_base') }} as table_alias
-- skadnetwork_properties at adsquads_base/skadnetwork_properties
where 1 = 1
and skadnetwork_properties is not null
{{ incremental_clause('_airbyte_extracted_at') }}

