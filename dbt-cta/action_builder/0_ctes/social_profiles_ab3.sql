{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('social_profiles_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'label',
        'source',
        'status',
        'profile',
        'entity_id',
        'created_at',
        'updated_at',
        'created_by_id',
        'updated_by_id',
        'social_network_type',
    ]) }} as _airbyte_social_profiles_hashid,
    tmp.*
from {{ ref('social_profiles_ab2') }} tmp
-- social_profiles
where 1 = 1

