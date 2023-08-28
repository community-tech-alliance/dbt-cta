{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('keys_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'sid',
        'date_created',
        'date_updated',
        'friendly_name',
    ]) }} as _airbyte_keys_hashid,
    tmp.*
from {{ ref('keys_ab2') }} as tmp
-- keys
where 1 = 1
