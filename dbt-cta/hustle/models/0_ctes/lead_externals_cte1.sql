-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`identifiers` as string) as `identifiers`,
    cast(`version` as string) as `version`,
    cast(`updated_at` as timestamp) as `updated_at`,
    cast(`lead_id` as string) as `lead_id`,
    cast(`created_at` as timestamp) as `created_at`,
    cast(`type` as string) as `type`,
    cast(`integration_id` as string) as `integration_id`,
    to_hex(md5(concat(
        `identifiers`,
        `version`,
        `updated_at`,
        `lead_id`,
        `created_at`,
        `type`,
        `integration_id`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_lead_externals_raw') }}
