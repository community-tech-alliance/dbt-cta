-- SQL model to aggregate `value` over hashid
-- depends_on: {{ ref('ads_insights_video_30_sec_watched_actions_ab1') }}
select
    _airbyte_ads_insights_hashid,
    SUM(cast(value as {{ dbt_utils.type_float() }})) as value
from {{ ref('ads_insights_video_30_sec_watched_actions_ab1') }}
-- video_30_sec_watched_actions at ads_insights/video_30_sec_watched_actions
where 1 = 1
GROUP BY _airbyte_ads_insights_hashid