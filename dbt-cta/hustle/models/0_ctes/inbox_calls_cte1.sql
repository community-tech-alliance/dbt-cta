-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select

    cast(`end_time` as timestamp) as end_time,
    cast(`result` as string) as result,
    cast(`calling_user_id` as string) as calling_user_id,
    cast(`attributed_inbox_goal_id` as string) as attributed_inbox_goal_id,
    cast(`created_at` as timestamp) as created_at,
    cast(`start_time` as timestamp) as start_time,
    cast(`inbox_thread_id` as string) as inbox_thread_id,
    cast(`direction` as string) as direction,
    cast(`lead_id` as string) as lead_id,
    cast(`organization_id` as string) as organization_id,
    cast(`updated_at` as timestamp) as updated_at,
    cast(`id` as string) as id,
    to_hex(md5(concat(
        `end_time`,
        `result`,
        `calling_user_id`,
        `attributed_inbox_goal_id`,
        `created_at`,
        `start_time`,
        `inbox_thread_id`,
        `direction`,
        `lead_id`,
        `organization_id`,
        `updated_at`,
        `id`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_inbox_calls_raw') }}
