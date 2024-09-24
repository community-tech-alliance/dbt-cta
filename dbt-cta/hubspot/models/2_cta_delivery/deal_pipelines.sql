select *
from {{ source('cta', 'deal_pipelines_base') }}
