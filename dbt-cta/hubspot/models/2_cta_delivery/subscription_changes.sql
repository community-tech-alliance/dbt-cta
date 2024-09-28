select *
from {{ source('cta', 'subscription_changes_base') }}
