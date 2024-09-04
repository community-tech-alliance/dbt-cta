{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('ads_insights_platform_and_device_ab3') }}
{{ unnest_cte(ref('ads_insights_platform_and_device_ab3'), 'ads_insights_platform_and_device_ab3', 'video_p100_watched_actions') }}
select
    _airbyte_ads_insights_platform_and_device_hashid,
    {{ json_extract_scalar(unnested_column_value('video_p100_watched_actions'), ['value'], ['value']) }} as value,
    {{ json_extract_scalar(unnested_column_value('video_p100_watched_actions'), ['1d_view'], ['1d_view']) }} as _1d_view,
    {{ json_extract_scalar(unnested_column_value('video_p100_watched_actions'), ['7d_view'], ['7d_view']) }} as _7d_view,
    {{ json_extract_scalar(unnested_column_value('video_p100_watched_actions'), ['1d_click'], ['1d_click']) }} as _1d_click,
    {{ json_extract_scalar(unnested_column_value('video_p100_watched_actions'), ['28d_view'], ['28d_view']) }} as _28d_view,
    {{ json_extract_scalar(unnested_column_value('video_p100_watched_actions'), ['7d_click'], ['7d_click']) }} as _7d_click,
    {{ json_extract_scalar(unnested_column_value('video_p100_watched_actions'), ['28d_click'], ['28d_click']) }} as _28d_click,
    {{ json_extract_scalar(unnested_column_value('video_p100_watched_actions'), ['action_type'], ['action_type']) }} as action_type,
    {{ json_extract_scalar(unnested_column_value('video_p100_watched_actions'), ['action_target_id'], ['action_target_id']) }} as action_target_id,
    {{ json_extract_scalar(unnested_column_value('video_p100_watched_actions'), ['action_destination'], ['action_destination']) }} as action_destination,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ads_insights_platform_and_device_ab3') }}
-- video_p100_watched_actions at ads_insights_platform_and_device/video_p100_watched_actions
{{ cross_join_unnest('ads_insights_platform_and_device_ab3', 'video_p100_watched_actions') }}
where
    1 = 1
    and video_p100_watched_actions is not null
{{ incremental_clause('_airbyte_extracted_at') }}

