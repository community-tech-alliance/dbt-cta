-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select

    cast(`created_at` as timestamp) as created_at,
    cast(`phone_number` as string) as phone_number,
    cast(`inbound_routing_number` as string) as inbound_routing_number,
    cast(`organization_id` as string) as organization_id,
    cast(`updated_at` as timestamp) as updated_at,
    cast(`id` as string) as id,
    to_hex(md5(concat(
        `created_at`,
        `phone_number`,
        `inbound_routing_number`,
        `organization_id`,
        `updated_at`,
        `id`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_inbox_addresses_raw') }}
