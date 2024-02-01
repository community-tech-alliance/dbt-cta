select *
from {{ source('cta', 'imports_error_rows_base') }}
