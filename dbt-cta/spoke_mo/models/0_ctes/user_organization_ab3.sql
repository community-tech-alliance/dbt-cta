{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_organization_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'role',
        'user_id',
        'organization_id',
        'id',
    ]) }} as _airbyte_user_organization_hashid,
    tmp.*
from {{ ref('user_organization_ab2') }} tmp
-- user_organization
where 1 = 1


