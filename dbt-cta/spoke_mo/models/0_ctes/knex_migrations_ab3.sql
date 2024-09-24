{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('knex_migrations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'migration_time',
        'name',
        'batch',
        'id',
    ]) }} as _airbyte_knex_migrations_hashid,
    tmp.*
from {{ ref('knex_migrations_ab2') }} as tmp
-- knex_migrations
where 1 = 1
