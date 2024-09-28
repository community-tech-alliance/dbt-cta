-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`updated_at` as timestamp) as `updated_at`,
    cast(`created_at` as timestamp) as `created_at`,
    cast(`organization_id` as string) as `organization_id`,
    cast(`deactivated_at` as string) as `deactivated_at`,
    cast(`name` as string) as `name`,
    cast(`id` as string) as `id`,
    to_hex(md5(concat(
        `updated_at`,
        `created_at`,
        `organization_id`,
        `name`,
        `id`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_groups_raw') }}
