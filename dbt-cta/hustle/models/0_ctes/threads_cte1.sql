-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`deleted_at` as string) as `deleted_at`,
    cast(`id` as string) as `id`,
    cast(`group_id` as string) as `group_id`,
    cast(`organization_id` as string) as `organization_id`,
    cast(`lead_id` as string) as `lead_id`,
    cast(`type` as string) as `type`,
    cast(`created_at` as timestamp) as `created_at`,
    cast(`updated_at` as timestamp) as `updated_at`,
    to_hex(md5(concat(
        `id`,
        `group_id`,
        `organization_id`,
        `lead_id`,
        `type`,
        `created_at`,
        `updated_at`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_threads_raw') }}
