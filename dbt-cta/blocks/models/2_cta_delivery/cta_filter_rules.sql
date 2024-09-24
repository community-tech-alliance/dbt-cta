select *
from {{ source('cta', 'filter_rules_base') }}
