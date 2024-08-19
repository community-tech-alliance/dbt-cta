{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_dev_fb_marketing_latest_conn"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('ads_insights_overall_ab3') }}
{{ unnest_cte(ref('ads_insights_overall_ab3'), 'ads_insights_overall_ab3', 'website_ctr') }}
select
    _airbyte_ads_insights_overall_hashid,
    {{ json_extract_scalar(unnested_column_value('website_ctr'), ['value'], ['value']) }} as value,
    {{ json_extract_scalar(unnested_column_value('website_ctr'), ['1d_view'], ['1d_view']) }} as _1d_view,
    {{ json_extract_scalar(unnested_column_value('website_ctr'), ['7d_view'], ['7d_view']) }} as _7d_view,
    {{ json_extract_scalar(unnested_column_value('website_ctr'), ['1d_click'], ['1d_click']) }} as _1d_click,
    {{ json_extract_scalar(unnested_column_value('website_ctr'), ['28d_view'], ['28d_view']) }} as _28d_view,
    {{ json_extract_scalar(unnested_column_value('website_ctr'), ['7d_click'], ['7d_click']) }} as _7d_click,
    {{ json_extract_scalar(unnested_column_value('website_ctr'), ['28d_click'], ['28d_click']) }} as _28d_click,
    {{ json_extract_scalar(unnested_column_value('website_ctr'), ['action_type'], ['action_type']) }} as action_type,
    {{ json_extract_scalar(unnested_column_value('website_ctr'), ['action_target_id'], ['action_target_id']) }} as action_target_id,
    {{ json_extract_scalar(unnested_column_value('website_ctr'), ['action_destination'], ['action_destination']) }} as action_destination,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ads_insights_overall_ab3') }}
-- website_ctr at ads_insights_overall/website_ctr
{{ cross_join_unnest('ads_insights_overall_ab3', 'website_ctr') }}
where
    1 = 1
    and website_ctr is not null
{{ incremental_clause('_airbyte_extracted_at') }}
