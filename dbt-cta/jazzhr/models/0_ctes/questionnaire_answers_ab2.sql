{{ config(
    cluster_by = "airbyte_extracted_at",
    partition_by = {"field": "airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('questionnaire_answers_ab1') }}
select
    cast(questionnaire_id as {{ dbt_utils.type_string() }}) as questionnaire_id,
    cast(questionnaire_code as {{ dbt_utils.type_string() }}) as questionnaire_code,
    cast(answer_value_00 as {{ dbt_utils.type_string() }}) as answer_value_00,
    cast(time_taken as {{ dbt_utils.type_string() }}) as time_taken,
    cast(applicant_id as {{ dbt_utils.type_string() }}) as applicant_id,
    cast(answer_value_03 as {{ dbt_utils.type_string() }}) as answer_value_03,
    cast(answer_value_04 as {{ dbt_utils.type_string() }}) as answer_value_04,
    cast(job_id as {{ dbt_utils.type_string() }}) as job_id,
    cast(answer_value_01 as {{ dbt_utils.type_string() }}) as answer_value_01,
    cast(answer_correct_01 as {{ dbt_utils.type_string() }}) as answer_correct_01,
    cast(answer_value_02 as {{ dbt_utils.type_string() }}) as answer_value_02,
    cast(answer_correct_00 as {{ dbt_utils.type_string() }}) as answer_correct_00,
    cast(answer_correct_03 as {{ dbt_utils.type_string() }}) as answer_correct_03,
    cast(answer_correct_02 as {{ dbt_utils.type_string() }}) as answer_correct_02,
    cast(answer_correct_04 as {{ dbt_utils.type_string() }}) as answer_correct_04,
    cast(date_taken as {{ dbt_utils.type_string() }}) as date_taken,
    airbyte_raw_id,
    airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('questionnaire_answers_ab1') }}
-- questionnaire_answers
where 1 = 1

