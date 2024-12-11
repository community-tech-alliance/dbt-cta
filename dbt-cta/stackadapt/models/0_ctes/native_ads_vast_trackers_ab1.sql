{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('native_ads_base') }}
{{ unnest_cte(ref('native_ads_base'), 'native_ads', 'vast_trackers') }}
select
    _airbyte_native_ads_hashid,
    {{ json_extract_scalar(unnested_column_value('vast_trackers'), ['url'], ['url']) }} as url,
    {{ json_extract_scalar(unnested_column_value('vast_trackers'), ['event_type'], ['event_type']) }} as event_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('native_ads_base') }}
-- vast_trackers at native_ads/vast_trackers
{{ cross_join_unnest('native_ads', 'vast_trackers') }}
where
    1 = 1
    and vast_trackers is not null
