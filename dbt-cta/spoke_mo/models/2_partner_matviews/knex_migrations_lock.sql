select
    is_locked,
    index,
    _airbyte_extracted_at,
    _airbyte_knex_migrations_lock_hashid
from {{ source('cta','knex_migrations_lock_base') }}