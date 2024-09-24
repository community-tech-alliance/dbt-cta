select *
from {{ source('cta', 'taggable_logbook_base') }}
