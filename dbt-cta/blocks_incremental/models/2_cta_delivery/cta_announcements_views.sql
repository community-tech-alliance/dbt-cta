select *
from {{ source('cta', 'announcements_views_base') }}
