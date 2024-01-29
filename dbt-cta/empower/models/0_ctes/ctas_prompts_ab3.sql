{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ctas_prompts_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_ctas_hashid',
        'ctaId',
        'vanId',
        boolean_to_string('isDeleted'),
        'ordering',
        array_to_string('answers'),
        'answerInputType',
        'id',
        'promptText',
        'dependsOnInitialDispositionResponse',
    ]) }} as _airbyte_prompts_hashid,
    tmp.*
from {{ ref('ctas_prompts_ab2') }} tmp
-- prompts at ctas/prompts
where 1 = 1

