{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('knex_migrations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'batch',
        'migration_time',
    ]) }} as _airbyte_knex_migrations_hashid,
    tmp.*
from {{ ref('knex_migrations_ab2') }} tmp
-- knex_migrations
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

