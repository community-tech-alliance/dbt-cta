{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('electoral_districts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'code',
        'name',
        'ocd_id',
        'created_at',
        'updated_at',
    ]) }} as _airbyte_electoral_districts_hashid,
    tmp.*
from {{ ref('electoral_districts_ab2') }} tmp
-- electoral_districts
where 1 = 1

