select
  id,
  tag_id,
  created_at,
  campaign_contact_id,
  _cta_loaded_at
from {{ source('cta', 'campaign_contacts_tags_base') }}
