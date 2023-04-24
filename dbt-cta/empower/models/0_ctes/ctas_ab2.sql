{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ctas_ab1') }}
select
    turfCuttingType,
    cast(textCanvassingType as {{ dbt_utils.type_string() }}) as textCanvassingType,
    associatedElectionId,
    defaultPriorityLabelKey,
    cast(createdMts as {{ dbt_utils.type_bigint() }}) as createdMts,
    questions,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    regionIds,
    customRecruitmentPromptText,
    cast(organizationId as {{ dbt_utils.type_bigint() }}) as organizationId,
    cast(scheduledLaunchTimeMts as {{ dbt_utils.type_bigint() }}) as scheduledLaunchTimeMts,
    {{ cast_to_boolean('shouldDisplayEarlyVotingPollingLocation') }} as shouldDisplayEarlyVotingPollingLocation,
    cast(updatedMts as {{ dbt_utils.type_bigint() }}) as updatedMts,
    spokeCampaignId,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    shareables,
    recruitmentTrainingUrl,
    prompts,
    {{ cast_to_boolean('isIntroCta') }} as isIntroCta,
    cast(recruitmentQuestionType as {{ dbt_utils.type_string() }}) as recruitmentQuestionType,
    {{ cast_to_boolean('shouldUseAdvancedTargeting') }} as shouldUseAdvancedTargeting,
    {{ cast_to_boolean('hasAssignableTurfs') }} as hasAssignableTurfs,
    {{ cast_to_boolean('isBatchImportDone') }} as isBatchImportDone,
    prioritizations,
    {{ cast_to_boolean('isPersonal') }} as isPersonal,
    cast(activeUntilMts as {{ dbt_utils.type_bigint() }}) as activeUntilMts,
    cast(actionType as {{ dbt_utils.type_string() }}) as actionType,
    cast(instructionsHtml as {{ dbt_utils.type_string() }}) as instructionsHtml,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(conversationStarter as {{ dbt_utils.type_string() }}) as conversationStarter,
    {{ cast_to_boolean('shouldDisplayElectionDayPollingLocation') }} as shouldDisplayElectionDayPollingLocation,
    {{ cast_to_boolean('isGeocodingDone') }} as isGeocodingDone,
    advancedTargetingFilter,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ctas_ab1') }}
-- ctas
where 1 = 1

