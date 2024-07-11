select
    migration_time,
    name,
    batch,
    id,
    _airbyte_extracted_at,
    _airbyte_knex_migrations_hashid
from {{ source('cta','knex_migrations_base') }}