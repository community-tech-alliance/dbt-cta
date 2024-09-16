-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`matching_strategy` as string) as `matching_strategy`,
    cast(`goal_id` as string) as `goal_id`,
    cast(`organization_id` as string) as `organization_id`,
    cast(`type` as string) as `type`,
    cast(`created_at` as timestamp) as `created_at`,
    cast(`updated_at` as timestamp) as `updated_at`,
    cast(`id` as string) as `id`,
    to_hex(md5(concat(
        `updated_at`,
        `id`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_goal_steps_raw') }}
