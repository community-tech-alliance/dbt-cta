select *
from {{ source('cta', 'ad_account_base') }}
