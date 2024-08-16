select *
from {{ source('cta','usage_records_base') }}
