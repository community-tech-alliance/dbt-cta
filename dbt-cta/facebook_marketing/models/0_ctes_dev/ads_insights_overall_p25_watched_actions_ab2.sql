-- SQL model to aggregate `value` over hashid
-- depends_on: {{ ref('ads_insights_overall_p25_watched_actions_ab1') }}
select
    _airbyte_ads_insights_overall_hashid,
    SUM(cast(value as {{ dbt_utils.type_float() }})) as value
from {{ ref('ads_insights_overall_p25_watched_actions_ab1') }}
-- video_p25_watched_actions at ads_insights_overall/video_p25_watched_actions
where 1 = 1
GROUP BY _airbyte_ads_insights_overall_hashid
