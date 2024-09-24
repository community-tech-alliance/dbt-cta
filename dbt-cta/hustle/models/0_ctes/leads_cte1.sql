-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`custom_fields` as string) as `custom_fields`,
    cast(`tags` as string) as `tags`,
    cast(`notes` as string) as `notes`,
    cast(`email` as string) as `email`,
    cast(`phone_number_type` as string) as `phone_number_type`,
    cast(`occupation` as string) as `occupation`,
    cast(`global_opted_out` as boolean) as `global_opted_out`,
    cast(`organization_id` as string) as `organization_id`,
    cast(`employer` as string) as `employer`,
    cast(`opt_out_type` as string) as `opt_out_type`,
    cast(`phone_number` as integer) as `phone_number`,
    cast(`first_name` as string) as `first_name`,
    cast(`created_at` as timestamp) as `created_at`,
    cast(`id` as string) as `id`,
    cast(`pii_redacted_at` as string) as `pii_redacted_at`,
    cast(`last_name` as string) as `last_name`,
    cast(`externals` as string) as `externals`,
    cast(`updated_at` as timestamp) as `updated_at`,
    to_hex(md5(concat(
        `id`,
        `updated_at`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_leads_raw') }}
