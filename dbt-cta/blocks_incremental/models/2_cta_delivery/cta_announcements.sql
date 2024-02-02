select *
from {{ source('cta', 'announcements_base') }}
