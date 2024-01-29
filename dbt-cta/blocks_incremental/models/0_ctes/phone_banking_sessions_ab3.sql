{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('phone_banking_sessions_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'completed_at',
        'phone_bank_id',
        'updated_at',
        'user_id',
        'created_at',
        'id',
        'caller_survey_response',
    ]) }} as _airbyte_phone_banking_sessions_hashid,
    tmp.*
from {{ ref('phone_banking_sessions_ab2') }} as tmp
-- phone_banking_sessions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

