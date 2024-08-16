{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('voice_calls_export_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'last_any_error_at',
        'selected_voterbase_id',
        'user_last_name',
        'created_at',
        'type',
        'contact_id',
        'duration',
        'van_id',
        'user_first_name',
        'updated_at',
        'call_count',
        'activity_id',
        'no_answer_count',
        'activity_published_at',
        'id',
        'aasm_state',
        'first_name',
        'campaign_id',
        'activity_title',
        'user_email',
        'twilio_answered_by',
        'last_busy_status_at',
        'last_name',
        'busy_count',
        'answered_at',
        'exported_at',
        'queue_time',
        'last_no_answer_status_at',
        'user_id',
    ]) }} as _airbyte_voice_calls_export_hashid,
    tmp.*
from {{ ref('voice_calls_export_ab2') }} tmp
-- voice_calls_export
where 1 = 1

