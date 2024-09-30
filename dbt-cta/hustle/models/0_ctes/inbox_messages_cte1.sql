-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`created_at` as timestamp) as created_at,
    cast(`lead_id` as string) as lead_id,	
    cast(`organization_id` as string) as organization_id,	
    cast(`updated_at` as timestamp) as updated_at,	
    cast(`inbox_address_id` as string) as inbox_address_id,	
    cast(`id` as string) as id,	
    to_hex(md5(concat(
        `created_at`,
        `lead_id`,	
        `organization_id`,	
        `updated_at`,	
        `inbox_address_id`,	
        `id`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_inbox_messages_raw') }}
