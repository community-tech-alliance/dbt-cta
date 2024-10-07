{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_ctas" %}
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
select
    {{ json_extract('table_alias', '_airbyte_data', ['turfCuttingType']) }} as turfCuttingType,
    {{ json_extract_scalar('_airbyte_data', ['textCanvassingType'], ['textCanvassingType']) }} as textCanvassingType,
    {{ json_extract('table_alias', '_airbyte_data', ['associatedElectionId']) }} as associatedElectionId,
    {{ json_extract('table_alias', '_airbyte_data', ['defaultPriorityLabelKey']) }} as defaultPriorityLabelKey,
    {{ json_extract_scalar('_airbyte_data', ['createdMts'], ['createdMts']) }} as createdMts,
    {{ json_extract_array('_airbyte_data', ['questions'], ['questions']) }} as questions,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_string_array('_airbyte_data', ['regionIds'], ['regionIds']) }} as regionIds,
    {{ json_extract('table_alias', '_airbyte_data', ['customRecruitmentPromptText']) }} as customRecruitmentPromptText,
    {{ json_extract_scalar('_airbyte_data', ['organizationId'], ['organizationId']) }} as organizationId,
    {{ json_extract_scalar('_airbyte_data', ['scheduledLaunchTimeMts'], ['scheduledLaunchTimeMts']) }} as scheduledLaunchTimeMts,
    {{ json_extract_scalar('_airbyte_data', ['shouldDisplayEarlyVotingPollingLocation'], ['shouldDisplayEarlyVotingPollingLocation']) }} as shouldDisplayEarlyVotingPollingLocation,
    {{ json_extract_scalar('_airbyte_data', ['updatedMts'], ['updatedMts']) }} as updatedMts,
    {{ json_extract('table_alias', '_airbyte_data', ['spokeCampaignId']) }} as spokeCampaignId,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_array('_airbyte_data', ['shareables'], ['shareables']) }} as shareables,
    {{ json_extract('table_alias', '_airbyte_data', ['recruitmentTrainingUrl']) }} as recruitmentTrainingUrl,
    {{ json_extract_array('_airbyte_data', ['prompts'], ['prompts']) }} as prompts,
    {{ json_extract_scalar('_airbyte_data', ['isIntroCta'], ['isIntroCta']) }} as isIntroCta,
    {{ json_extract_scalar('_airbyte_data', ['recruitmentQuestionType'], ['recruitmentQuestionType']) }} as recruitmentQuestionType,
    {{ json_extract_scalar('_airbyte_data', ['shouldUseAdvancedTargeting'], ['shouldUseAdvancedTargeting']) }} as shouldUseAdvancedTargeting,
    {{ json_extract_scalar('_airbyte_data', ['hasAssignableTurfs'], ['hasAssignableTurfs']) }} as hasAssignableTurfs,
    {{ json_extract_scalar('_airbyte_data', ['isBatchImportDone'], ['isBatchImportDone']) }} as isBatchImportDone,
    {{ json_extract_array('_airbyte_data', ['prioritizations'], ['prioritizations']) }} as prioritizations,
    {{ json_extract_scalar('_airbyte_data', ['isPersonal'], ['isPersonal']) }} as isPersonal,
    {{ json_extract_scalar('_airbyte_data', ['activeUntilMts'], ['activeUntilMts']) }} as activeUntilMts,
    {{ json_extract_scalar('_airbyte_data', ['actionType'], ['actionType']) }} as actionType,
    {{ json_extract_scalar('_airbyte_data', ['instructionsHtml'], ['instructionsHtml']) }} as instructionsHtml,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['conversationStarter'], ['conversationStarter']) }} as conversationStarter,
    {{ json_extract_scalar('_airbyte_data', ['shouldDisplayElectionDayPollingLocation'], ['shouldDisplayElectionDayPollingLocation']) }} as shouldDisplayElectionDayPollingLocation,
    {{ json_extract_scalar('_airbyte_data', ['isGeocodingDone'], ['isGeocodingDone']) }} as isGeocodingDone,
    {{ json_extract('table_alias', '_airbyte_data', ['advancedTargetingFilter']) }} as advancedTargetingFilter,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }} as table_alias
where 1 = 1
