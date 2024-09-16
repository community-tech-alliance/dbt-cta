-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`direction` as string) as `direction`,
    cast(`lead_id` as string) as `lead_id`,
    cast(`attributed_goal_id` as string) as `attributed_goal_id`,
    cast(`thread_id` as string) as `thread_id`,
    cast(`organization_id` as string) as `organization_id`,
    cast(`agent_id` as string) as `agent_id`,
    cast(`type` as string) as `type`,
    cast(`created_at` as timestamp) as `created_at`,
    cast(`group_id` as string) as `group_id`,
    cast(`message` as string) as `message`,
    cast(`id` as string) as `id`,
    cast(`pii_redacted_at` as string) as `pii_redacted_at`,
    cast(`workflow_id` as string) as `workflow_id`,
    cast(`updated_at` as timestamp) as `updated_at`,
    to_hex(md5(concat(
        `organization_id`,
        `created_at`,
        `group_id`,
        `id`,
        `updated_at`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_messages_raw') }}
