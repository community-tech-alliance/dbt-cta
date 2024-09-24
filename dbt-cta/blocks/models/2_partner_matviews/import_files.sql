select *
from {{ source('cta', 'import_files_base') }}
