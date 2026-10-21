{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_ctas" %}
-- Extracts each column from the raw JSON and casts it, then builds a hash of the record
with extracted as (
    select
        _airbyte_raw_id,
        _airbyte_extracted_at,
        {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
        {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
        {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
        {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
        {{ json_extract_scalar('_airbyte_data', ['actionType'], ['actionType']) }} as actionType,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['createdMts'], ['createdMts']) }} as int64) as createdMts,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['isIntroCta'], ['isIntroCta']) }} as bool) as isIntroCta,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['updatedMts'], ['updatedMts']) }} as int64) as updatedMts,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['activeUntilMts'], ['activeUntilMts']) }} as int64) as activeUntilMts,
        {{ json_extract_scalar('_airbyte_data', ['organizationId'], ['organizationId']) }} as organizationId,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['isGeocodingDone'], ['isGeocodingDone']) }} as bool) as isGeocodingDone,
        {{ json_extract_scalar('_airbyte_data', ['prioritizations'], ['prioritizations']) }} as prioritizations,
        {{ json_extract_scalar('_airbyte_data', ['turfCuttingType'], ['turfCuttingType']) }} as turfCuttingType,
        {{ json_extract_scalar('_airbyte_data', ['instructionsHtml'], ['instructionsHtml']) }} as instructionsHtml,
        {{ json_extract_scalar('_airbyte_data', ['conversationStarter'], ['conversationStarter']) }} as conversationStarter,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['shouldShowMatchButton'], ['shouldShowMatchButton']) }} as bool) as shouldShowMatchButton,
        {{ json_extract_scalar('_airbyte_data', ['contactTargetingFilter'], ['contactTargetingFilter']) }} as contactTargetingFilter,
        {{ json_extract_scalar('_airbyte_data', ['recruitmentTrainingUrl'], ['recruitmentTrainingUrl']) }} as recruitmentTrainingUrl,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['scheduledLaunchTimeMts'], ['scheduledLaunchTimeMts']) }} as int64) as scheduledLaunchTimeMts,
        {{ json_extract_scalar('_airbyte_data', ['advancedTargetingFilter'], ['advancedTargetingFilter']) }} as advancedTargetingFilter,
        {{ json_extract_scalar('_airbyte_data', ['defaultPriorityLabelKey'], ['defaultPriorityLabelKey']) }} as defaultPriorityLabelKey,
        {{ json_extract_scalar('_airbyte_data', ['recruitmentQuestionType'], ['recruitmentQuestionType']) }} as recruitmentQuestionType,
        {{ json_extract_scalar('_airbyte_data', ['canvassingTargetingFilter'], ['canvassingTargetingFilter']) }} as canvassingTargetingFilter,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['shouldUseAdvancedTargeting'], ['shouldUseAdvancedTargeting']) }} as bool) as shouldUseAdvancedTargeting,
        {{ json_extract_scalar('_airbyte_data', ['customRecruitmentPromptText'], ['customRecruitmentPromptText']) }} as customRecruitmentPromptText,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['shouldDisplayEarlyVotingPollingLocation'], ['shouldDisplayEarlyVotingPollingLocation']) }} as bool) as shouldDisplayEarlyVotingPollingLocation,
        safe_cast({{ json_extract_scalar('_airbyte_data', ['shouldDisplayElectionDayPollingLocation'], ['shouldDisplayElectionDayPollingLocation']) }} as bool) as shouldDisplayElectionDayPollingLocation
    from {{ source('cta_raw', raw_table) }}
)

select
    *,
    {{ dbt_utils.surrogate_key([
        'id',
        'description',
        'name',
        'status',
        'actionType',
        'createdMts',
        'isIntroCta',
        'updatedMts',
        'activeUntilMts',
        'organizationId',
        'isGeocodingDone',
        'prioritizations',
        'turfCuttingType',
        'instructionsHtml',
        'conversationStarter',
        'shouldShowMatchButton',
        'contactTargetingFilter',
        'recruitmentTrainingUrl',
        'scheduledLaunchTimeMts',
        'advancedTargetingFilter',
        'defaultPriorityLabelKey',
        'recruitmentQuestionType',
        'canvassingTargetingFilter',
        'shouldUseAdvancedTargeting',
        'customRecruitmentPromptText',
        'shouldDisplayEarlyVotingPollingLocation',
        'shouldDisplayElectionDayPollingLocation'
    ]) }} as _airbyte_ctas_hashid
from extracted
