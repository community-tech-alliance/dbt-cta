-- SQL model to cast the raw STRING columns to their source types and add feed metadata
-- Columns Qomon adds to the feed later pass through as STRING
-- depends_on: {{ source('cta', '_raw_custom_fields') }}

select
    * replace (
        safe_cast(id as int64) as id,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(created_at, r' [A-Z]+$', '')) as created_at,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(updated_at, r' [A-Z]+$', '')) as updated_at,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(deleted_at, r' [A-Z]+$', '')) as deleted_at,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(date, r' [A-Z]+$', '')) as date,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(done_date, r' [A-Z]+$', '')) as done_date,
        safe_cast(group_id as int64) as group_id,
        safe_cast(contact_id as int64) as contact_id,
        safe_cast(form_id as int64) as form_id,
        safe_cast(form_ref_id as int64) as form_ref_id,
        safe_cast(fact_id as int64) as fact_id,
        safe_cast(survey_id as int64) as survey_id
    ),
    parse_timestamp('%Y%m%dT%H%M%SZ', regexp_extract(_source_file, r'_(\d{8}T\d{6}Z)\.csv$')) as _extracted_at,
    regexp_extract(_source_file, r'^gs://[^/]+/(.*)\d{4}/\d{2}/\d{2}/[^/]+$') as _feed_prefix
from {{ source('cta', '_raw_custom_fields') }}
