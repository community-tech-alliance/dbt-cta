select * from {{ source('cta', 'import_row_errors_base') }}
