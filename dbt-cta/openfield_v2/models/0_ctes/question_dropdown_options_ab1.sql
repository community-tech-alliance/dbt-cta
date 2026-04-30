-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_question_dropdown_options') }}

select
    question_id,
    campaign_id,
    option_id,
    option_name,
    {{ dbt_utils.surrogate_key([
        'question_id',
        'campaign_id',
        'option_id'
    ]) }} as _question_dropdown_options_hashid,
    current_timestamp() as _cta_loaded_at
from {{ source('cta', '_stg_question_dropdown_options') }}
