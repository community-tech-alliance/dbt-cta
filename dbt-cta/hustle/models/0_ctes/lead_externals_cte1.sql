-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`
        
SELECT
    CAST(`identifiers` AS STRING) AS `identifiers`,
    CAST(`version` AS STRING) AS `version`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`lead_id` AS STRING) AS `lead_id`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`type` AS STRING) AS `type`,
    CAST(`integration_id` AS STRING) AS `integration_id`,
    TO_HEX(MD5(CONCAT(`identifiers`,
                      `version`,
                      `updated_at`,
                      `lead_id`,
                      `created_at`,
                      `type`,
                      `integration_id`))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_lead_externals_raw') }}