-- depends_on: {{ ref('ab1_upsert_contacts') }}

select
    *
from {{ ref('ab1_upsert_contacts') }}