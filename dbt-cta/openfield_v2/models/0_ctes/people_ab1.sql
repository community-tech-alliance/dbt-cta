-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_people') }}

select
    id,
    state_file_id,
    first_name,
    middle_name,
    last_name,
    suffix,
    preferred_name,
    sex,
    age,
    phone1,
    phone2,
    phone3,
    phone4,
    email1,
    email_opt_in1,
    is_deceased,
    van_id,
    other_voter_file_id,
    my_campaign_id,
    registered_national_address_id_id,
    contacted_national_address_id_id,
    mailing_national_address_id_id,
    provided_national_address_id_id,
    current_timestamp() as _cta_loaded_at
from {{ source('cta', '_stg_people') }}
