{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('quality_control_phone_verification_calls_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'number',
        boolean_to_string('external'),
        'updated_at',
        'voter_registration_scan_id',
        'user_id',
        'twilio_call_id',
        'created_at',
        'id',
        'disconnected_at',
        'status',
    ]) }} as _airbyte_quality_control_phone_verification_calls_hashid,
    tmp.*
from {{ ref('quality_control_phone_verification_calls_ab2') }} tmp
-- quality_control_phone_verification_calls
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

