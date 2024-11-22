select *
from {{ source('cta', 'taggings_base') }}
