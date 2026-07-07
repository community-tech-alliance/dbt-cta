select *
from {{ source('cta', 'label_base') }}
