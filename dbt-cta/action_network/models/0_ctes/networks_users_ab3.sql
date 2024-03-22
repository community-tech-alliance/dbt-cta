{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('networks_users_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'user_id',
        'created_at',
        'network_id',
        'updated_at',
        'accepted_terms',
    ]) }} as _airbyte_networks_users_hashid,
    tmp.*
from {{ ref('networks_users_ab2') }} as tmp
-- networks_users
where 1 = 1
