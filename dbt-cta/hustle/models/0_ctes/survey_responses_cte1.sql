-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`
                    
SELECT
    CAST(`integration_id` AS STRING) AS `integration_id`,
    CAST(`formatted_value` AS STRING) AS `formatted_value`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`survey_question_id` AS STRING) AS `survey_question_id`,
    CAST(`organization_id` AS STRING) AS `organization_id`,
    CAST(`van_survey_response_id` AS INTEGER) AS `van_survey_response_id`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`id` AS STRING) AS `id`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`integration_id`,
                                        `formatted_value`,
                                        `updated_at`,
                                        `survey_question_id`,
                                        `organization_id`,
                                        `van_survey_response_id`,
                                        `created_at`,
                                        `id`))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_survey_responses_raw') }}
    
    