select *
from {{ source('cta','daily_campaign_dials_base') }}