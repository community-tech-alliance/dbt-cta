{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('quality_control_phone_verification_question_translations_ab1') }}
select
    cast(translation_text as {{ dbt_utils.type_string() }}) as translation_text,
    cast(script_id as {{ dbt_utils.type_bigint() }}) as script_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(question_id as {{ dbt_utils.type_bigint() }}) as question_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('quality_control_phone_verification_question_translations_ab1') }}
-- quality_control_phone_verification_question_translations
where 1 = 1
