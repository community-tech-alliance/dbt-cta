select *
from {{ source('cta', 'deals_archived_base') }}
