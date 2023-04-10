{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "empower_partner_a",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='ctas_prompts_scd'
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
-- depends_on: {{ ref('ctas_prompts_ab3') }}
select
    _airbyte_ctas_hashid,
    ctaId,
    vanId,
    isDeleted,
    ordering,
    answers,
    answerInputType,
    id,
    promptText,
    dependsOnInitialDispositionResponse,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_prompts_hashid
from {{ ref('ctas_prompts_ab3') }}
-- prompts at ctas/prompts from {{ ref('ctas') }}
where 1 = 1

