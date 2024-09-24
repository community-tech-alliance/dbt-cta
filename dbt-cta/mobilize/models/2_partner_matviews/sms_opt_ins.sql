-- depends_on: {{ source('cta', 'sms_opt_ins_base') }}
select
    _airbyte_sms_opt_ins_hashid,
    max(id) as id,
    max(user_id) as user_id,
    max(created_date) as created_date,
    max(modified_date) as modified_date,
    max(organization_id) as organization_id,
    max(sms_opt_in_status) as sms_opt_in_status,
    max(user__phone_number) as user__phone_number,
    max(_airbyte_raw_id) as _airbyte_raw_id,
    max(_airbyte_extracted_at) as _airbyte_extracted_at
from {{ source("cta", "sms_opt_ins_base") }}
group by _airbyte_sms_opt_ins_hashid
