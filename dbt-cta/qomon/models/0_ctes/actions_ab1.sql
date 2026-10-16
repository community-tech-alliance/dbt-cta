-- SQL model to cast the raw STRING columns to their source types and add feed metadata
-- Columns Qomon adds to the feed later pass through as STRING
-- depends_on: {{ source('cta', '_raw_actions') }}

select
    * replace (
        safe_cast(id as int64) as id,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(created_at, r' [A-Z]+$', '')) as created_at,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(updated_at, r' [A-Z]+$', '')) as updated_at,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(deleted_at, r' [A-Z]+$', '')) as deleted_at,
        safe_cast(group_id as int64) as group_id,
        safe_cast(goal as int64) as goal,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(start, r' [A-Z]+$', '')) as start,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(`end`, r' [A-Z]+$', '')) as `end`,
        safe_cast(polling_station_included_missing as bool) as polling_station_included_missing,
        safe_cast(polling_station_excluded_missing as bool) as polling_station_excluded_missing,
        safe_cast(address_included_missing as bool) as address_included_missing,
        safe_cast(address_excluded_missing as bool) as address_excluded_missing,
        safe_cast(excluded_nevada as bool) as excluded_nevada,
        safe.parse_json(polling_station_included) as polling_station_included,
        safe.parse_json(polling_station_excluded) as polling_station_excluded,
        safe.parse_json(address_included) as address_included,
        safe.parse_json(address_excluded) as address_excluded,
        safe.parse_json(not_polygon) as not_polygon,
        safe_cast(goal_forms as int64) as goal_forms,
        safe_cast(aggreg_without_location as bool) as aggreg_without_location,
        safe.parse_timestamp('%F %H:%M:%E*S %z', regexp_replace(type_form_disabled_at, r' [A-Z]+$', '')) as type_form_disabled_at,
        safe_cast(created_by as int64) as created_by,
        safe.parse_json(advanced_search) as advanced_search,
        safe_cast(public as bool) as public,
        safe.parse_json(cover_img) as cover_img,
        safe_cast(all_users as bool) as all_users,
        safe_cast(restricted as bool) as restricted,
        safe_cast(hide_broadcast_link as bool) as hide_broadcast_link,
        safe_cast(maximum_capacity as int64) as maximum_capacity,
        safe_cast(promote_sharing as bool) as promote_sharing,
        safe_cast(featured as bool) as featured,
        safe_cast(survey_id as int64) as survey_id
    ),
    parse_timestamp('%Y%m%dT%H%M%SZ', regexp_extract(_source_file, r'_(\d{8}T\d{6}Z)\.csv$')) as _extracted_at,
    regexp_extract(_source_file, r'^gs://[^/]+/(.*)\d{4}/\d{2}/\d{2}/[^/]+$') as _feed_prefix
from {{ source('cta', '_raw_actions') }}
