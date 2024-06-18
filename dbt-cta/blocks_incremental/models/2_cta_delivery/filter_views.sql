select *
from {{ source('cta', 'filter_views_base') }}
