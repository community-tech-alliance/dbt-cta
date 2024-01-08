{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('quality_control_phone_verification_question_translations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'translation_text',
        'script_id',
        'id',
        'question_id',
    ]) }} as _airbyte_quality_control_phone_verification_question_translations_hashid,
    tmp.*
from {{ ref('quality_control_phone_verification_question_translations_ab2') }} as tmp
-- quality_control_phone_verification_question_translations
where 1 = 1
