{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('call_targets_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'uuid',
        'bioid',
        'status',
        'call_id',
        'created_at',
        'updated_at',
        'target_name',
        'target_type',
        'target_party',
        'target_phone',
        'target_state',
        'call_duration',
        'target_country',
        'target_district',
        'target_position',
    ]) }} as _airbyte_call_targets_hashid,
    tmp.*
from {{ ref('call_targets_ab2') }} as tmp
-- call_targets
where 1 = 1
