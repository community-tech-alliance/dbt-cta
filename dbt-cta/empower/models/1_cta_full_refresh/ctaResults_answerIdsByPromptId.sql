{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "empower_partner_a",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='ctaResults_answerIdsByPromptId_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('ctaResults_answerIdsByPromptId_ab3') }}
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
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_answerIdsByPromptId_hashid
from {{ ref('ctaResults_answerIdsByPromptId_ab3') }}
-- answerIdsByPromptId at ctaResults/answerIdsByPromptId from {{ ref('ctaResults') }}
where 1 = 1

