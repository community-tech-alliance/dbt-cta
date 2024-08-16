-- depends_on: {{ source('cta', 'ad_set_report_base') }}
select *
from {{ source('cta', 'ad_set_report_base') }}
