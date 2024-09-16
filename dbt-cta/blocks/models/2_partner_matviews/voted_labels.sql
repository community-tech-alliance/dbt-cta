select *
from {{ source('cta', 'voted_labels_base') }}
