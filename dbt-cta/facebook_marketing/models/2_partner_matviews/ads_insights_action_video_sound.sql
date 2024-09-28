select *
from {{ source('cta', 'ads_insights_action_video_sound_base') }}
