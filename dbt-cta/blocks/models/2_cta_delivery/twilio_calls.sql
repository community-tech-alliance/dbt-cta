select *
from {{ source('cta', 'twilio_calls_base') }}
