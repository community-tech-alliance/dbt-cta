select *
from {{ source('cta', 'activist_code_counts_base') }}
