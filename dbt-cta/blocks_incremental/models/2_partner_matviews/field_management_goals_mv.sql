select *
from {{ source('cta', 'field_management_goals_base') }}
