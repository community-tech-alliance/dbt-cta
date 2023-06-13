-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`
        
SELECT
    CAST(`identifiers` AS STRING) AS `identifiers`,
    CAST(`version` AS STRING) AS `version`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`type` AS STRING) AS `type`,
    CAST(`integration_id` AS STRING) AS `integration_id`,
    CAST(`goal_id` AS STRING) AS `goal_id`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`identifiers`,
                                        `version`,
                                        `updated_at`,
                                        `created_at`,
                                        `type`,
                                        `integration_id`,
                                        `goal_id`))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_goal_externals_raw') }}