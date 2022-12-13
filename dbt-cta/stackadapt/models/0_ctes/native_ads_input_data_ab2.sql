{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('native_ads_input_data_ab1') }}
select
    _airbyte_native_ads_hashid,
    cast(heading as {{ dbt_utils.type_string() }}) as heading,
    cast(tagline as {{ dbt_utils.type_string() }}) as tagline,
    cast(vast_xml as {{ dbt_utils.type_string() }}) as vast_xml,
    cast(landing_url as {{ dbt_utils.type_string() }}) as landing_url,
    audio_creatives,
    video_creatives,
    display_js_creative,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_input_data_ab1') }}
-- input_data at native_ads/input_data
where 1 = 1

