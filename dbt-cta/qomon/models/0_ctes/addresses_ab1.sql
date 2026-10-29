-- SQL model to cast the raw STRING columns to their source types and add feed metadata
-- Columns Qomon adds to the feed later pass through as STRING
-- depends_on: {{ source('cta', '_raw_addresses') }}

select
    * replace (
        safe_cast(id as int64) as id,
        safe_cast(score as numeric) as score,
        safe_cast(invalid as bool) as invalid,
        safe_cast(immut_key as int64) as immut_key,
        safe.parse_json(auto_territories) as auto_territories
    ),
    parse_timestamp('%Y%m%dT%H%M%SZ', regexp_extract(_source_file, r'_(\d{8}T\d{6}Z)\.csv$')) as _extracted_at,
    regexp_extract(_source_file, r'^gs://[^/]+/(.*?)/?\d{4}/\d{2}/\d{2}/[^/]+$') as _feed_prefix
from {{ source('cta', '_raw_addresses') }}
