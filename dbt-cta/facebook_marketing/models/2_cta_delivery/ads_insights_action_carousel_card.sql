select *
from {{ source('cta', 'ads_insights_action_carousel_card_base') }}
