-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_conversation_code') }}

select
    id,
    campaign_id,
    code,
    description,
    org,
    script_id,
    list_id,
    conversation_type,
    conversation_type_description,
    min_turf_size,
    max_turf_size,
    attempt_goal,
    enable_retry,
    max_retry_attempts_per_contact,
    retry_interval_hours,
    enable_follow_up,
    release_turf_on_logoff,
    created_by_id,
    created_at,
    {{ dbt_utils.surrogate_key([
        'id',
        'campaign_id'
    ]) }} as _conversation_code_hashid,
    current_timestamp() as _cta_loaded_at
from {{ source('cta', '_stg_conversation_code') }}
