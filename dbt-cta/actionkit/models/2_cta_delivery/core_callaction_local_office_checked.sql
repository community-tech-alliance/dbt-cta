select *
from {{ source('cta', 'core_callaction_local_office_checked_base') }}
