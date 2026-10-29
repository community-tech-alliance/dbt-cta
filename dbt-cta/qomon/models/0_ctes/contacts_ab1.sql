-- SQL model to cast the raw STRING columns to their source types and add feed metadata
-- Columns Qomon adds to the feed later pass through as STRING
-- depends_on: {{ source('cta', '_raw_contacts') }}

select
    * replace (
        safe_cast(id as int64) as id,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(created_at, r' [A-Z]+$', '')) as created_at,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(updated_at, r' [A-Z]+$', '')) as updated_at,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(deleted_at, r' [A-Z]+$', '')) as deleted_at,
        safe.parse_date('%F', left(birthdate, 10)) as birthdate,
        safe_cast(age_category as int64) as age_category,
        safe_cast(address_id as int64) as address_id,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(last_change, r' [A-Z]+$', '')) as last_change,
        safe_cast(last_change_user_id as int64) as last_change_user_id,
        safe_cast(group_id as int64) as group_id,
        safe_cast(user_id as int64) as user_id,
        safe_cast(brevo_id as int64) as brevo_id,
        safe_cast(black_list as bool) as black_list,
        safe_cast(membership_number as int64) as membership_number,
        safe_cast(user_contact_id as int64) as user_contact_id,
        safe_cast(nation_builder_id as int64) as nation_builder_id,
        safe_cast(phone_invalid as bool) as phone_invalid,
        safe_cast(mobile_invalid as bool) as mobile_invalid,
        safe_cast(imported_by as int64) as imported_by,
        safe_cast(created_by as int64) as created_by
    ),
    parse_timestamp('%Y%m%dT%H%M%SZ', regexp_extract(_source_file, r'_(\d{8}T\d{6}Z)\.csv$')) as _extracted_at,
    regexp_extract(_source_file, r'^gs://[^/]+/(.*?)/?\d{4}/\d{2}/\d{2}/[^/]+$') as _feed_prefix
from {{ source('cta', '_raw_contacts') }}
