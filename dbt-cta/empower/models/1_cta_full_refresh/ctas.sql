{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "empower_partner_a",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='ctas_scd'
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
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('ctas_ab3') }}
select
    turfCuttingType,
    textCanvassingType,
    associatedElectionId,
    defaultPriorityLabelKey,
    createdMts,
    questions,
    description,
    regionIds,
    customRecruitmentPromptText,
    organizationId,
    scheduledLaunchTimeMts,
    shouldDisplayEarlyVotingPollingLocation,
    updatedMts,
    spokeCampaignId,
    id,
    shareables,
    recruitmentTrainingUrl,
    prompts,
    isIntroCta,
    recruitmentQuestionType,
    shouldUseAdvancedTargeting,
    hasAssignableTurfs,
    isBatchImportDone,
    prioritizations,
    isPersonal,
    activeUntilMts,
    actionType,
    instructionsHtml,
    name,
    conversationStarter,
    shouldDisplayElectionDayPollingLocation,
    isGeocodingDone,
    advancedTargetingFilter,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ctas_hashid
from {{ ref('ctas_ab3') }}
-- ctas from {{ source('empower_partner_a', '_airbyte_raw_ctas') }}
where 1 = 1

