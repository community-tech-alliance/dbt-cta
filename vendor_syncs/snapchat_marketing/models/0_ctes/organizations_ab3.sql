{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('organizations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'created_at',
    ]) }} as _airbyte_organizations_hashid,
    tmp.*
from {{ ref('organizations_ab2') }} tmp
-- organizations
where 1 = 1

