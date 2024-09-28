-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`description` as string) as `description`,
    cast(`name` as string) as `name`,
    cast(`id` as string) as `id`,
    cast(`group_id` as string) as `group_id`,
    cast(`organization_id` as string) as `organization_id`,
    cast(`type` as string) as `type`,
    cast(`created_at` as timestamp) as `created_at`,
    cast(`updated_at` as timestamp) as `updated_at`,
    to_hex(md5(concat(
        `updated_at`,
        `id`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_goals_raw') }}
