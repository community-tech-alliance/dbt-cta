-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`integration_id` as string) as `integration_id`,
    cast(`question` as string) as `question`,
    cast(`van_survey_question_id` as integer) as `van_survey_question_id`,
    cast(`goal_step_id` as string) as `goal_step_id`,
    cast(`goal_id` as string) as `goal_id`,
    cast(`organization_id` as string) as `organization_id`,
    cast(`created_at` as timestamp) as `created_at`,
    cast(`updated_at` as timestamp) as `updated_at`,
    cast(`id` as string) as `id`,
    to_hex(md5(concat(
        `integration_id`,
        `question`,
        `van_survey_question_id`,
        `goal_step_id`,
        `goal_id`,
        `organization_id`,
        `created_at`,
        `updated_at`,
        `id`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_survey_questions_raw') }}
