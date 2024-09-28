select *
from {{ source('cta', 'ads_insights_action_reaction_base') }}
