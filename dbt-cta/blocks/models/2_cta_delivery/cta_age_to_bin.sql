select *
from {{ source('cta', 'age_to_bin_base') }}
