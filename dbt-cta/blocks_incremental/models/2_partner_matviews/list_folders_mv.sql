select *
from {{ source('cta', 'list_folders_base') }}
