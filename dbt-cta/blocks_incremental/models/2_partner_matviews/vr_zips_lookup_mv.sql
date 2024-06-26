select *
from {{ source('cta', 'vr_zips_lookup_base') }}
