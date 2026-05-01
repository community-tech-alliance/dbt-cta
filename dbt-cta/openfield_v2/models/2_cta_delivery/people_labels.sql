select *
from {{ source('cta', 'people_labels_base') }}
