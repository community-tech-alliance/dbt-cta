-- CTE:
-- casts fields to data types
-- creates _cta_hash_id

select
    cast(person_id as string) as person_id,
    cast(record_id as string) as record_id,
    cast(contact_attempt_record_id as string) as contact_attempt_record_id,
    cast(state_code as string) as state_code,
    cast(contact_type_name as string) as contact_type_name,
    cast(contact_result_name as string) as contact_result_name,
    cast(exchange_survey_question_response_name as string) as exchange_survey_question_response_name,
    cast(datetime_pulled as timestamp) as datetime_pulled,
    cast(datetime_window_start as timestamp) as datetime_window_start,
    cast(datetime_window_end as timestamp) as datetime_window_end,
    cast(survey_question_text as string) as survey_question_text,
    cast(major_question_type as string) as major_question_type,
    cast(election_type as string) as election_type,
    cast(gov_level as string) as gov_level,
    cast(minor_question_type as string) as minor_question_type,
    cast(office as string) as office,
    cast(rank as string) as rank,
    cast(survey_response_set as string) as survey_response_set,
    cast(language as string) as language,
    cast(exchange_survey_question_id as string) as exchange_survey_question_id,
    cast(full_name as string) as full_name,
    cast(election_date as string) as election_date,
    cast(ballot_measure_name as string) as ballot_measure_name,
    cast(issue as string) as issue,
    cast(collection_method as string) as collection_method,
    cast(district_name as string) as district_name,
    cast(contest_type as string) as contest_type,
    cast(election_metadata as string) as election_metadata,
    cast(_cta_loaded_at as timestamp) as _cta_loaded_at,
    cast(subscription_name as string) as subscription_name,
  {{ dbt_utils.surrogate_key([
    'person_id',
    'record_id'
  ]) }} as _cta_hash_id
from {{ source('cta', '_survey_response_v2_raw') }}
