select *
from {{ source('cta', 'email_subscriptions_base') }}
