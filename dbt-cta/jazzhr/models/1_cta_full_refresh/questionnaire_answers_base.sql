{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_raw_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('questionnaire_answers_ab4') }}
select
    questionnaire_id,
    questionnaire_code,
    answer_value_00,
    time_taken,
    applicant_id,
    answer_value_03,
    answer_value_04,
    job_id,
    answer_value_01,
    answer_correct_01,
    answer_value_02,
    answer_correct_00,
    answer_correct_03,
    answer_correct_02,
    answer_correct_04,
    date_taken,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_questionnaire_answers_hashid
from {{ ref('questionnaire_answers_ab4') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_extracted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}