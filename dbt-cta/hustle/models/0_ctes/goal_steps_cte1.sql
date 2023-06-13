-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

SELECT
    CAST(`matching_strategy` AS STRING) AS `matching_strategy`,
    CAST(`goal_id` AS STRING) AS `goal_id`,
    CAST(`organization_id` AS STRING) AS `organization_id`,
    CAST(`type` AS STRING) AS `type`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`id` AS STRING) AS `id`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`matching_strategy`,
                                        `goal_id`,
                                        `organization_id`,
                                        `type`,
                                        `created_at`,
                                        `updated_at`,
                                        `id`))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_goal_steps_raw') }}
    
    