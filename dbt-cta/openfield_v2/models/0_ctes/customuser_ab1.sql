-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_customuser') }}

select
    id,
    campaign_id,
    email,
    first_name,
    last_name,
    pronouns,
    languages_spoken,
    zip_code,
    cell_phone,
    admin_level,
    date_joined,
    last_login,
    is_active,
    is_quarantined,
    {{ dbt_utils.surrogate_key([
        'id',
        'campaign_id'
    ]) }} as _customuser_hashid,
    {{ current_timestamp() }} as _cta_loaded_at
from {{ source('cta', '_stg_customuser') }}
