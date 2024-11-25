select *
from {{ source('cta','universe_builder_raw_base') }}
