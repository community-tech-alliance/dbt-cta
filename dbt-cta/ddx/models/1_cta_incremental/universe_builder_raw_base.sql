{{ config(
    partition_by = {"field": "datetime_pulled", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_cta_hash_id",
    tags = [ "universe-builder-raw" ],
    persist_docs = {"columns": true, "relation": true}
) }}

select
    person_id,
    state_code,
    contact_type_name,
    contact_result_name,
    exchange_survey_question_code,
    exchange_survey_question_response_name,
    aggregate_exchange_survey_question_code,
    aggregate_exchange_survey_question_response_name,
    record_id,
    contact_attempt_record_id,
    datetime_pulled,
    datetime_canvassed_window_start,
    datetime_canvassed_window_end,
    client_slug,
    universe_name,
    corrid,
    _cta_loaded_at,
    _cta_hash_id
from {{ ref('universe_builder_raw_cte2') }}
