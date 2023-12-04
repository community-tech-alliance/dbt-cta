{{ config(
    partition_by = {"field": "datetime_pulled", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_cta_hash_id",
    tags = [ "survey-response" ],
    persist_docs = {"columns": true}
) }}

select
    person_id,
    state_code,
    contact_type_name,
    contact_result_name,
    exchange_survey_question_code,
    exchange_survey_question_response_name,
    aggregated_exchange_survey_question_code,
    aggregated_exchange_survey_question_response_name,
    record_id,
    contact_attempt_record_id,
    datetime_pulled,
    datetime_canvassed_window_start,
    datetime_canvassed_window_end,
    subscription_name,
    _cta_loaded_at,
    _cta_hash_id
from {{ ref('survey_response_cte2') }}
