select *
from {{ source('cta','customers_preferences_base') }}
