select *
from {{ source('cta', 'friendly_id_slugs_base') }}
