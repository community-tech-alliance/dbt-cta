-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`
        
SELECT
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`deleted_at` AS STRING) AS `deleted_at`,
    CAST(`deactivated_at` AS STRING) AS `deactivated_at`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`lead_id` AS STRING) AS `lead_id`,
    CAST(`group_id` AS STRING) AS `group_id`,
    CAST(`organization_id` AS STRING) AS `organization_id`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`updated_at`,
                                        `deleted_at`,
                                        `deactivated_at`,
                                        `created_at`,
                                        `lead_id`,
                                        `group_id`,
                                        `organization_id`))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_group_memberships_raw') }}