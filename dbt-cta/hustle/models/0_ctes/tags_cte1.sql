-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`deleted_at` as string) as `deleted_at`,
    cast(`id` as string) as `id`,
    cast(`agent_visibility` as string) as `agent_visibility`,
    cast(`organization_id` as string) as `organization_id`,
    cast(`tag` as string) as `tag`,
    cast(`created_at` as timestamp) as `created_at`,
    cast(`updated_at` as timestamp) as `updated_at`,
    to_hex(md5(concat(
        `id`,
        `tag`,
        `created_at`,
        `updated_at`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_tags_raw') }}
