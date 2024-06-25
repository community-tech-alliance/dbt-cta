select *
from {{ source('cta', 'campaign_report_base') }}
