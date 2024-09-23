select
   {{ dbt_utils.surrogate_key([
    'caller_first_name',
    'caller_last_name',
    'caller_phone_number',
    'caller_email'
    ]) }} as _caller_activity_details_hashid,
    * -- use * in case custom fields get added
from {{ source('cta', '_raw_caller_activity_details') }}
