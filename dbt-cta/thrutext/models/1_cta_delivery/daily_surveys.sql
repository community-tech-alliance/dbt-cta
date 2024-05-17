select *
from {{ source('cta','daily_surveys_base') }}
