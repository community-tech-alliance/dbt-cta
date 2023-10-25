{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('v2_voice_calls_export_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'selected_voterbase_id',
        'user_last_name',
        'created_at',
        'source',
        'contact_id',
        'duration',
        'reference',
        'van_id',
        'user_first_name',
        'updated_at',
        'stopped_reason',
        boolean_to_string('reported'),
        'activity_id',
        'activity_published_at',
        'id',
        'stopped_at',
        'first_name',
        'campaign_id',
        'activity_title',
        'user_email',
        'twilio_answered_by',
        'last_name',
        'answered_at',
        'exported_at',
        'pdi_id',
        'phone',
        'user_id',
    ]) }} as _airbyte_v2_voice_calls_export_hashid,
    tmp.*
from {{ ref('v2_voice_calls_export_ab2') }} tmp
-- v2_voice_calls_export
where 1 = 1

