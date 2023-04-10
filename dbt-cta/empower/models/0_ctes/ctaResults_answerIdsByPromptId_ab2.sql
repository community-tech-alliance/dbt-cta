{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_empower_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ctaResults_answerIdsByPromptId_ab1') }}
select
    _airbyte_ctaResults_hashid,
    _13805,
    _13198,
    _13683,
    _13197,
    _13684,
    _13800,
    _13303,
    _13304,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ctaResults_answerIdsByPromptId_ab1') }}
-- answerIdsByPromptId at ctaResults/answerIdsByPromptId
where 1 = 1

