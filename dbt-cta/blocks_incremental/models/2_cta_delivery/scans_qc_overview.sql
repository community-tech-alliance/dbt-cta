select *
from {{ source('cta', 'scans_qc_overview_base') }}
