select *
from {{ source('cta', 'attachments_base') }}
