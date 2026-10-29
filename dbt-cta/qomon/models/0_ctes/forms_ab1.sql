-- SQL model to cast the raw STRING columns to their source types and add feed metadata
-- Columns Qomon adds to the feed later pass through as STRING
-- depends_on: {{ source('cta', '_raw_forms') }}

select
    * replace (
        safe_cast(id as int64) as id,
        safe_cast(`order` as int64) as `order`,
        array(select safe_cast(element as int64) from unnest(split(trim(group_id, '{}'), ',')) as element where element != '') as group_id,
        safe_cast(filterbyidrefvalue as int64) as filterbyidrefvalue,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(created_at, r' [A-Z]+$', '')) as created_at,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(updated_at, r' [A-Z]+$', '')) as updated_at,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(deleted_at, r' [A-Z]+$', '')) as deleted_at,
        safe_cast(tag_for_nb as bool) as tag_for_nb,
        safe_cast(mandatory as bool) as mandatory,
        safe_cast(hidden as bool) as hidden,
        array(select safe_cast(element as int64) from unnest(split(trim(default_refvalues_id, '{}'), ',')) as element where element != '') as default_refvalues_id,
        safe_cast(read_only as bool) as read_only,
        safe_cast(hidden_web as bool) as hidden_web,
        safe_cast(step_number as int64) as step_number
    ),
    parse_timestamp('%Y%m%dT%H%M%SZ', regexp_extract(_source_file, r'_(\d{8}T\d{6}Z)\.csv$')) as _extracted_at,
    regexp_extract(_source_file, r'^gs://[^/]+/(.*?)/?\d{4}/\d{2}/\d{2}/[^/]+$') as _feed_prefix
from {{ source('cta', '_raw_forms') }}
