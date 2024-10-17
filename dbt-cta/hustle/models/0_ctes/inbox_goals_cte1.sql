-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select

    cast(`initial_workflow_type` as string) as initial_workflow_type,
    cast(`name` as string) as name,
    cast(`id` as string) as id,
    cast(`inbox_address_id` as string) as inbox_address_id,
    cast(`organization_id` as string) as organization_id,
    cast(`created_at` as timestamp) as created_at,
    cast(`updated_at` as timestamp) as updated_at,
    to_hex(md5(concat(
        `initial_workflow_type`,
        `name`,
        `id`,
        `inbox_address_id`,
        `organization_id`,
        `created_at`,
        `updated_at`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_inbox_goals_raw') }}
