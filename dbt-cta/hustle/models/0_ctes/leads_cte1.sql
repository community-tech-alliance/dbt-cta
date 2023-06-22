-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`
        
SELECT
    CAST(`custom_fields` AS STRING) AS `custom_fields`,
    CAST(`tags` AS STRING) AS `tags`,
    CAST(`notes` AS STRING) AS `notes`,
    CAST(`email` AS STRING) AS `email`,
    CAST(`phone_number_type` AS STRING) AS `phone_number_type`,
    CAST(`occupation` AS STRING) AS `occupation`,
    CAST(`global_opted_out` AS BOOLEAN) AS `global_opted_out`,
    CAST(`organization_id` AS STRING) AS `organization_id`,
    CAST(`employer` AS STRING) AS `employer`,
    CAST(`opt_out_type` AS STRING) AS `opt_out_type`,
    CAST(`phone_number` AS INTEGER) AS `phone_number`,
    CAST(`first_name` AS STRING) AS `first_name`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`id` AS STRING) AS `id`,
    CAST(`pii_redacted_at` AS STRING) AS `pii_redacted_at`,
    CAST(`last_name` AS STRING) AS `last_name`,
    CAST(`externals` AS STRING) AS `externals`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    TO_HEX(MD5(CONCAT(
                      `id`,
                      `updated_at`))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_leads_raw') }}
    
    