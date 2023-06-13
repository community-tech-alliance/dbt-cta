-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`
             
SELECT
    CAST(`deleted_at` AS TIMESTAMP) AS `deleted_at`,
    CAST(`user_id` AS STRING) AS `user_id`,
    CAST(`id` AS STRING) AS `id`,
    CAST(`group_id` AS STRING) AS `group_id`,
    CAST(`organization_id` AS STRING) AS `organization_id`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    TO_HEX(MD5(CONCAT(
                      `updated_at`,
                      `id`
                    ))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_agents_raw') }}
    
    