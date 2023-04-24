{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('profileorganizationtags_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'profileEid',
        'tagId',
    ]) }} as _airbyte_profileorganizationtags_hashid,
    tmp.*
from {{ ref('profileorganizationtags_ab2') }} tmp
-- profileorganizationtags
where 1 = 1

