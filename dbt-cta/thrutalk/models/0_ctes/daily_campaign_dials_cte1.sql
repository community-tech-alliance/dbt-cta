select
   {{ dbt_utils.surrogate_key([
    'contact_first_name',
    'contact_last_name',
    'contact_phone',
    'time_dialed_est'
    ]) }} as _daily_campaign_dials_hashid,
    * -- use * in case custom fields get added
from {{ source('cta', '_raw_daily_campaign_dials') }}
