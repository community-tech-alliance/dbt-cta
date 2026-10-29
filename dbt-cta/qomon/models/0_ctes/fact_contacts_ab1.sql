-- SQL model to cast the raw STRING columns to their source types and add feed metadata
-- Columns Qomon adds to the feed later pass through as STRING
-- depends_on: {{ source('cta', '_raw_fact_contacts') }}

select
    * replace (
        safe_cast(fact_id as int64) as fact_id,
        safe_cast(contact_id as int64) as contact_id
    ),
    parse_timestamp('%Y%m%dT%H%M%SZ', regexp_extract(_source_file, r'_(\d{8}T\d{6}Z)\.csv$')) as _extracted_at,
    regexp_extract(_source_file, r'^gs://[^/]+/(.*?)/?\d{4}/\d{2}/\d{2}/[^/]+$') as _feed_prefix
from {{ source('cta', '_raw_fact_contacts') }}
