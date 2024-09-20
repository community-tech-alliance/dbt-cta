select *
from {{ source('cta','caller_activity_details_base') }}