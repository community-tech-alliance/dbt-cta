select *
from {{ source('cta', 'core_reengagementlog_base') }}
