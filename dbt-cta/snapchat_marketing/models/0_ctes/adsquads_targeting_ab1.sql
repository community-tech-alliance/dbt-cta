{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('adsquads_base') }}
select
    id as ad_squad_id,
    {{ json_extract_array('targeting', ['geos'], ['geos']) }} as geos,
    {{ json_extract_array('targeting', ['demographics'], ['demographics']) }} as demographics,
    {{ json_extract_scalar('targeting', ['regulated_content'], ['regulated_content']) }} as regulated_content,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adsquads_base') }}
-- targeting at adsquads_base/targeting
where
    1 = 1
    and targeting is not null
{{ incremental_clause('_airbyte_extracted_at') }}

