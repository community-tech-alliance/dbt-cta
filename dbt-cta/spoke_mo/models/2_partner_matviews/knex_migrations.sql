select
    migration_time,
    name,
    batch,
    id,
    _airbyte_emitted_at,
    _airbyte_knex_migrations_hashid
from {{ source('cta','knex_migrations_base') }}