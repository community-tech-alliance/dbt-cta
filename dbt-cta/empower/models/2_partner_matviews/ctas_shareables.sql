select
    displayLabel,
    type,
    url,
from {{ ref('ctas_shareables_base') }}