-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_conversations') }}

select
    id,
    campaign_id,
    conversation_time,
    conversation_code_id,
    contact_script_id,
    canvasser_id,
    contacted_id_id,
    contact,
    contact_type,
    contact_type_description,
    conversation_outcome_type,
    conversation_outcome_type_description,
    language,
    notes,
    contacted_phone,
    contacted_national_address_id_id,
    contacted_full_address,
    contacted_city,
    contacted_state,
    contacted_zip_5,
    contacted_zip_4,
    attempt_after_time,
    is_quarantined,
    {{ dbt_utils.surrogate_key([
        'id',
        'campaign_id'
    ]) }} as _conversations_hashid,
    current_timestamp() as _cta_loaded_at
from {{ source('cta', '_stg_conversations') }}
