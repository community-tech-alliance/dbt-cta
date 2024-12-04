select *
from {{ source('cta','redshift_people_attempts_base') }}
