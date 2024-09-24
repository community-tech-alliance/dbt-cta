-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`message_id` as string) as `message_id`,
    cast(`goal_step_id` as string) as `goal_step_id`,
    cast(`value_str` as string) as `value_str`,
    cast(`agent_id` as string) as `agent_id`,
    cast(`created_at` as timestamp) as `created_at`,
    cast(`lead_id` as string) as `lead_id`,
    cast(`goal_id` as string) as `goal_id`,
    cast(`organization_id` as string) as `organization_id`,
    cast(`updated_at` as timestamp) as `updated_at`,
    cast(`id` as string) as `id`,
    to_hex(md5(concat(
        `updated_at`,
        `id`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_agent_actions_raw') }}
