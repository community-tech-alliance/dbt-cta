select
    displayLabel,
    type,
    url,
from {{ source('cta','ctas_shareables_base') }}