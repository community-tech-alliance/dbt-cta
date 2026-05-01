-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_conversations_attempts_lookup') }}

select
    conversation_id,
    campaign_id,
    list_id,
    person_id,
    {{ dbt_utils.surrogate_key([
      'conversation_id',
      'campaign_id',
      'list_id',
      'person_id'
    ]) }} as _conversations_attempts_lookup_hashid,
    current_timestamp() as _cta_loaded_at
from {{ source('cta', '_stg_conversations_attempts_lookup') }}
