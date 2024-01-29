{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('phone_banking_calls_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'phone_bank_id',
        'round_canvass_status',
        'called_by_user_id',
        boolean_to_string('participated'),
        'twilio_call_id',
        'extras',
        'created_at',
        'non_participation_reason',
        boolean_to_string('external'),
        'round',
        'updated_at',
        'locked_at',
        'locked_by_user_id',
        'id',
        'status',
        'person_id',
    ]) }} as _airbyte_phone_banking_calls_hashid,
    tmp.*
from {{ ref('phone_banking_calls_ab2') }} tmp
-- phone_banking_calls
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

