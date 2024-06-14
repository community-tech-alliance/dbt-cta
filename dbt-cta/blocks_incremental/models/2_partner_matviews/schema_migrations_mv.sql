select *
from {{ source('cta', 'schema_migrations_base') }}
