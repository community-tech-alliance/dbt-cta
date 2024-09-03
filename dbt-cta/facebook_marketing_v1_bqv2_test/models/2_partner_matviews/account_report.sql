select *
from {{ source('cta', 'account_report_base') }}
