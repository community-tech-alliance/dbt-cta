{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('phone_verification_responses_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'round_number',
        'notes',
        'updated_at',
        'voter_registration_scan_id',
        'response',
        'created_at',
        'id',
        'created_by_user_id',
        'call_id',
        'phone_verification_question_id',
    ]) }} as _airbyte_phone_verification_responses_hashid,
    tmp.*
from {{ ref('phone_verification_responses_ab2') }} tmp
-- phone_verification_responses
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

