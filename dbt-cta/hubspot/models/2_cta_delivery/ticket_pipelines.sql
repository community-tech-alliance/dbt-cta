select *
from {{ source('cta', 'ticket_pipelines_base') }}
