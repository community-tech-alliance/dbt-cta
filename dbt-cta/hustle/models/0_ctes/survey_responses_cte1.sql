-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`

select
    cast(`integration_id` as string) as `integration_id`,
    cast(`formatted_value` as string) as `formatted_value`,
    cast(`updated_at` as timestamp) as `updated_at`,
    cast(`survey_question_id` as string) as `survey_question_id`,
    cast(`organization_id` as string) as `organization_id`,
    cast(`van_survey_response_id` as integer) as `van_survey_response_id`,
    cast(`created_at` as timestamp) as `created_at`,
    cast(`id` as string) as `id`,
    to_hex(md5(concat(
        `integration_id`,
        `updated_at`,
        `survey_question_id`,
        `organization_id`,
        `van_survey_response_id`,
        `created_at`,
        `id`
    ))) as _cta_hashid,
    current_timestamp() as _cta_sync_datetime_utc
from {{ source('cta', '_survey_responses_raw') }}
