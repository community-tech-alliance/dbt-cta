select
  id,
  script,
  question,
  created_at,
  is_deleted,
  campaign_id,
  answer_option,
  answer_actions,
  answer_actions_data,
  parent_interaction_id,
  _cta_loaded_at
from {{ source('cta', 'interaction_steps_base') }}
