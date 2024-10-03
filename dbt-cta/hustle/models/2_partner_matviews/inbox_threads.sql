select *
from {{ source('cta','inbox_threads_base') }}
