-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`created_at` as timestamp) as `created_at`,
    cast(`type` as string) as `type`,
    cast(`updated_at` as timestamp) as `updated_at`,
    cast(`name` as string) as `name`,
    cast(`id` as string) as `id`,
    to_hex(md5(concat(
        `created_at`,
        `type`,
        `updated_at`,
        `name`,
        `id`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_integrations_raw') }}
