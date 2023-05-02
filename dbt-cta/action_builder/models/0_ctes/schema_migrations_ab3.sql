{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('schema_migrations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'version',
    ]) }} as _airbyte_schema_migrations_hashid,
    tmp.*
from {{ ref('schema_migrations_ab2') }} tmp
-- schema_migrations
where 1 = 1

