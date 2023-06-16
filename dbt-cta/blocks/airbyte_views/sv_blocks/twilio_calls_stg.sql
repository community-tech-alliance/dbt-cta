{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('twilio_calls_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'updated_at',
        'user_id',
        'remote_id',
        'created_at',
        'phone_number',
        'id',
        'scan_id',
        'disconnected_at',
        'duration_in_seconds',
    ]) }} as _airbyte_twilio_calls_hashid,
    tmp.*
from {{ ref('twilio_calls_ab2') }} tmp
-- twilio_calls
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

