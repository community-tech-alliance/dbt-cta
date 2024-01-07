select *
from {{ source('cta', 'voter_histories_base') }}
