select
    _airbyte_extracted_at,
    _airbyte_ctas_hashid,
    displayLabel,
    type,
    url,
    _airbyte_shareables_hashid
from {{ source('cta','ctas_shareables_base') }}
