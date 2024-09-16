{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('adsquads_targeting_base') }}
{{ unnest_cte(ref('adsquads_targeting_base'), 'targeting', 'geos') }}
select
    ad_squad_id,
    {{ json_extract_scalar(unnested_column_value('geos'), ['country_code'], ['country_code']) }} as country_code,
    {{ extract_snapchat_geo('region_id') }}[safe_ordinal(1)] as region_id,
    {{ extract_snapchat_geo('metro') }}[safe_ordinal(1)] as metro,
    {{ extract_snapchat_geo('postal_code') }}[safe_ordinal(1)] as postal_code,
    -- NOTE: The snapchat marketing documentation mentions an "electoral" geo type,
    -- but it doesn't appear in any of our test data, so leaving it out for now.
    {{ json_extract_scalar(unnested_column_value('geos'), ['operation'], ['operation']) }} as operation,
    geos,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adsquads_targeting_base') }}
-- geos at adsquads_base/targeting/geos
{{ cross_join_unnest('targeting', 'geos') }}
where
    1 = 1
    and geos is not null
{{ incremental_clause('_airbyte_extracted_at') }}

