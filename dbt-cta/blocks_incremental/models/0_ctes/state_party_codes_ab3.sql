{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('state_party_codes_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'code',
        'updated_at',
        'party_id',
        'created_at',
        'id',
        'state',
    ]) }} as _airbyte_state_party_codes_hashid,
    tmp.*
from {{ ref('state_party_codes_ab2') }} as tmp
-- state_party_codes
where 1 = 1
