{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('api_keys_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'target',
        'api_key',
        'created_at',
        'revoked_at',
        'updated_at',
        'created_by_id',
        'revoked_by_id',
    ]) }} as _airbyte_api_keys_hashid,
    tmp.*
from {{ ref('api_keys_ab2') }} as tmp
-- api_keys
where 1 = 1
