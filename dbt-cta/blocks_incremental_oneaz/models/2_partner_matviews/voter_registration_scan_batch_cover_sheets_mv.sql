select *
from {{ source('cta', 'voter_registration_scan_batch_cover_sheets_base') }}
