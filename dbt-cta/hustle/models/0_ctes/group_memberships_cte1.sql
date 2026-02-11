-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`updated_at` as timestamp) as `updated_at`,
    cast(`deleted_at` as string) as `deleted_at`,
    cast(`deactivated_at` as string) as `deactivated_at`,
    cast(`created_at` as timestamp) as `created_at`,
    cast(`lead_id` as string) as `lead_id`,
    cast(`group_id` as string) as `group_id`,
    cast(`organization_id` as string) as `organization_id`,
    to_hex(md5(concat(
        `lead_id`,
        `group_id`,
        `organization_id`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_group_memberships_raw') }}
