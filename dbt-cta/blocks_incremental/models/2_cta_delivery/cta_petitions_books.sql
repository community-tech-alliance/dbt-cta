select *
from {{ source('cta', 'petitions_books_base') }}
