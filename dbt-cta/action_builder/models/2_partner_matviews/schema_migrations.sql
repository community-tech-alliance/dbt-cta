select
    _airbyte_emitted_at,
    version,
    _airbyte_schema_migrations_hashid
from {{ source('cta','schema_migrations_base') }}