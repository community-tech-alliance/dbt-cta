-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`
                              
SELECT
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`type` AS STRING) AS `type`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`name` AS STRING) AS `name`,
    CAST(`id` AS STRING) AS `id`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`created_at`,
                                        `type`,
                                        `updated_at`,
                                        `name`,
                                        `id`))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_integrations_raw') }}
    
    