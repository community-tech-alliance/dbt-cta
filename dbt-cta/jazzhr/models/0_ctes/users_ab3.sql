{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'date_created',
        'last_name',
        'id',
        'type',
        'first_name',
        'email',
    ]) }} as _airbyte_users_hashid,
    tmp.*
from {{ ref('users_ab2') }} as tmp
-- users
where 1 = 1
