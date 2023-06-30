select
    *
from {{ source('cta','search_documents_base') }}