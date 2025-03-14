-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`body` as string) as body,
    cast(`sending_broadcast_id` as string) as sending_broadcast_id,
    cast(`sending_user_id` as string) as sending_user_id,
    cast(`attributed_inbox_goal_id` as string) as attributed_inbox_goal_id,
    cast(`inbox_thread_id` as string) as inbox_thread_id,
    cast(`type` as string) as type,
    cast(`created_at` as timestamp) as created_at,
    cast(`direction` as string) as direction,
    cast(`lead_id` as string) as lead_id,
    cast(`organization_id` as string) as organization_id,
    cast(`updated_at` as timestamp) as updated_at,
    cast(`id` as string) as id,
    cast(`status` as string) as status,
    to_hex(md5(concat(
        `body`,
        `sending_broadcast_id`,
        `sending_user_id`,
        `attributed_inbox_goal_id`,
        `inbox_thread_id`,
        `type`,
        `created_at`,
        `direction`,
        `lead_id`,
        `organization_id`,
        `updated_at`,
        `id`,
        `status`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_inbox_messages_raw') }}
