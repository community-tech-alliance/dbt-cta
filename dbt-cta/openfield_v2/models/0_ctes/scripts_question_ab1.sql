-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_raw_scripts_question') }}

select
    id,
    campaign_id,
    script_id,
    question_id,
    q_order,
    is_required,
    {{ dbt_utils.surrogate_key([
        'id',
        'campaign_id'
    ]) }} as _scripts_hashid,
    current_timestamp() as _cta_loaded_at
from {{ source('cta', '_raw_scripts_question') }}
