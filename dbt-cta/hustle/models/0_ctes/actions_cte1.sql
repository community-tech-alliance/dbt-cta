-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

SELECT
    CAST(`goal_step_id` AS STRING) AS `goal_step_id`,
    CAST(`survey_response_id` AS STRING) AS `survey_response_id`,
    CAST(`value_str` AS STRING) AS `value_str`,
    CAST(`goal_id` AS STRING) AS `goal_id`,
    CAST(`agent_id` AS STRING) AS `agent_id`,
    CAST(`type` AS STRING) AS `type`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`lead_id` AS STRING) AS `lead_id`,
    CAST(`organization_id` AS STRING) AS `organization_id`,
    CAST(`survey_question_id` AS STRING) AS `survey_question_id`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`id` AS STRING) AS `id`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`goal_step_id`,
                                        `survey_response_id`,
                                        `value_str`,
                                        `goal_id`,
                                        `agent_id`,
                                        `type`,
                                        `created_at`,
                                        `lead_id`,
                                        `organization_id`,
                                        `survey_question_id`,
                                        `updated_at`,
                                        `id`))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_actions_raw') }}
    
    