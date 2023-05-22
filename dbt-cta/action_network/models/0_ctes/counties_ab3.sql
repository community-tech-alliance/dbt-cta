{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('counties_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'created_at',
        'updated_at',
        'county_state',
    ]) }} as _airbyte_counties_hashid,
    tmp.*
from {{ ref('counties_ab2') }} tmp
-- counties
where 1 = 1

