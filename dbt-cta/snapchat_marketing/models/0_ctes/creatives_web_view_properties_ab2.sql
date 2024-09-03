{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('creatives_web_view_properties_ab1') }}
select
    creative_id,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    {{ cast_to_boolean('block_preload') }} as block_preload,
    deep_link_urls,
    {{ cast_to_boolean('use_immersive_mode') }} as use_immersive_mode,
    {{ cast_to_boolean('allow_snap_javascript_sdk') }} as allow_snap_javascript_sdk,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('creatives_web_view_properties_ab1') }}
-- web_view_properties at creatives/web_view_properties
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

