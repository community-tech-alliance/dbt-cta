-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`identifiers` as string) as `identifiers`,
    cast(`version` as string) as `version`,
    cast(`updated_at` as timestamp) as `updated_at`,
    cast(`created_at` as timestamp) as `created_at`,
    cast(`type` as string) as `type`,
    cast(`integration_id` as string) as `integration_id`,
    cast(`goal_id` as string) as `goal_id`,
    to_hex(md5(concat(
        `updated_at`,
        `created_at`,
        `type`,
        `integration_id`,
        `goal_id`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_goal_externals_raw') }}
