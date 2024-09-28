-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`updated_at` as timestamp) as `updated_at`,
    cast(`created_at` as timestamp) as `created_at`,
    cast(`phone_number` as integer) as `phone_number`,
    cast(`preferred_name` as string) as `preferred_name`,
    cast(`email` as string) as `email`,
    cast(`username` as string) as `username`,
    cast(`full_name` as string) as `full_name`,
    cast(`id` as string) as `id`,
    to_hex(md5(concat(
        `updated_at`,
        `created_at`,
        `phone_number`,
        `email`,
        `username`,
        `full_name`,
        `id`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_users_raw') }}
