-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`
        
SELECT
    CAST(`direction` AS STRING) AS `direction`,
    CAST(`lead_id` AS STRING) AS `lead_id`,
    CAST(`attributed_goal_id` AS STRING) AS `attributed_goal_id`,
    CAST(`thread_id` AS STRING) AS `thread_id`,
    CAST(`organization_id` AS STRING) AS `organization_id`,
    CAST(`agent_id` AS STRING) AS `agent_id`,
    CAST(`type` AS STRING) AS `type`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`group_id` AS STRING) AS `group_id`,
    CAST(`message` AS STRING) AS `message`,
    CAST(`id` AS STRING) AS `id`,
    CAST(`pii_redacted_at` AS STRING) AS `pii_redacted_at`,
    CAST(`workflow_id` AS STRING) AS `workflow_id`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    TO_HEX(MD5(CONCAT(`organization_id`,
                      `created_at`,
                      `group_id`,
                      `id`,
                      `updated_at`))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_messages_raw') }}
    
    