{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
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
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}


