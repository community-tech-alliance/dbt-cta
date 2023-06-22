-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`
           
SELECT
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`organization_id` AS STRING) AS `organization_id`,
    CAST(`deactivated_at` AS STRING) AS `deactivated_at`,
    CAST(`name` AS STRING) AS `name`,
    CAST(`id` AS STRING) AS `id`,
    TO_HEX(MD5(CONCAT(`updated_at`,
                      `created_at`,
                      `organization_id`,
                      `name`,
                      `id`))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_groups_raw') }}
    
    