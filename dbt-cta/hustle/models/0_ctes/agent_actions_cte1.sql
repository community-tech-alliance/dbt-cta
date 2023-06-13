-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`
                  
SELECT
    CAST(`message_id` AS STRING) AS `message_id`,
    CAST(`goal_step_id` AS STRING) AS `goal_step_id`,
    CAST(`value_str` AS STRING) AS `value_str`,
    CAST(`agent_id` AS STRING) AS `agent_id`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`lead_id` AS STRING) AS `lead_id`,
    CAST(`goal_id` AS STRING) AS `goal_id`,
    CAST(`organization_id` AS STRING) AS `organization_id`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`id` AS STRING) AS `id`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`message_id`,
                                        `goal_step_id`,
                                        `value_str`,
                                        `agent_id`,
                                        `created_at`,
                                        `lead_id`,
                                        `goal_id`,
                                        `organization_id`,
                                        `updated_at`,
                                        `id`))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_agent_actions_raw') }}
    
    