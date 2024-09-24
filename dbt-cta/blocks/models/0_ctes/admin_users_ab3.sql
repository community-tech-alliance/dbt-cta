{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('admin_users_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'session',
        'id',
        'email',
        'encrypted_password',
    ]) }} as _airbyte_admin_users_hashid,
    tmp.*
from {{ ref('admin_users_ab2') }} as tmp
-- admin_users
where 1 = 1
