select *
from {{ source('cta', 'subscription_statuses_base') }}
