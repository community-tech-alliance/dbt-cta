-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_raw_question_responses') }}

select
    id,
    campaign_id,
    conversation_id_id,
    question_id,
    list_option_id,
    question_response,
    question_response_opt_in,
    created_at,
    created_by_id,
    {{ dbt_utils.surrogate_key([
        'id',
        'campaign_id'
    ]) }} as _question_responses_hashid,
    current_timestamp() as _cta_loaded_at
from {{ source('cta', '_raw_question_responses') }}
