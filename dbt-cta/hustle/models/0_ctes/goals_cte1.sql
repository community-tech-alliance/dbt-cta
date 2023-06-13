-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`
            
SELECT
    CAST(`description` AS STRING) AS `description`,
    CAST(`name` AS STRING) AS `name`,
    CAST(`id` AS STRING) AS `id`,
    CAST(`group_id` AS STRING) AS `group_id`,
    CAST(`organization_id` AS STRING) AS `organization_id`,
    CAST(`type` AS STRING) AS `type`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`description`,
                                        `name`,
                                        `id`,
                                        `group_id`,
                                        `organization_id`,
                                        `type`,
                                        `created_at`,
                                        `updated_at`))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_goals_raw') }}
    
    