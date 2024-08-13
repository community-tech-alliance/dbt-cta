
-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`
       
SELECT
    CAST(`integration_id` AS STRING) AS `integration_id`,
    CAST(`question` AS STRING) AS `question`,
    CAST(`van_survey_question_id` AS INTEGER) AS `van_survey_question_id`,
    CAST(`goal_step_id` AS STRING) AS `goal_step_id`,
    CAST(`goal_id` AS STRING) AS `goal_id`,
    CAST(`organization_id` AS STRING) AS `organization_id`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`id` AS STRING) AS `id`,
    TO_HEX(MD5(CONCAT(`integration_id`,
                      `question`,
                      `van_survey_question_id`,
                      `goal_step_id`,
                      `goal_id`,
                      `organization_id`,
                      `created_at`,
                      `updated_at`,
                      `id`))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_survey_questions_raw') }}
    
    