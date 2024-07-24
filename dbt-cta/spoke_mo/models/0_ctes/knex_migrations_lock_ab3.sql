{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('knex_migrations_lock_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'is_locked',
        'index',
    ]) }} as _airbyte_knex_migrations_lock_hashid,
    tmp.*
from {{ ref('knex_migrations_lock_ab2') }} tmp
-- knex_migrations_lock
where 1 = 1


