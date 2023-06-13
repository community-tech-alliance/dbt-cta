-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`
    
SELECT
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`phone_number` AS INTEGER) AS `phone_number`,
    CAST(`preferred_name` AS STRING) AS `preferred_name`,
    CAST(`email` AS STRING) AS `email`,
    CAST(`username` AS STRING) AS `username`,
    CAST(`full_name` AS STRING) AS `full_name`,
    CAST(`id` AS STRING) AS `id`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`updated_at`,
                                        `created_at`,
                                        `phone_number`,
                                        `preferred_name`,
                                        `email`,
                                        `username`,
                                        `full_name`,
                                        `id`))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_users_raw') }}
    
    