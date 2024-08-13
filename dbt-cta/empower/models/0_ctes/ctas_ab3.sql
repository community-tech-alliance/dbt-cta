{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ctas_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'turfCuttingType',
        'textCanvassingType',
        'associatedElectionId',
        'defaultPriorityLabelKey',
        'createdMts',
        array_to_string('questions'),
        'description',
        array_to_string('regionIds'),
        'customRecruitmentPromptText',
        'organizationId',
        'scheduledLaunchTimeMts',
        boolean_to_string('shouldDisplayEarlyVotingPollingLocation'),
        'updatedMts',
        'spokeCampaignId',
        'id',
        array_to_string('shareables'),
        'recruitmentTrainingUrl',
        array_to_string('prompts'),
        boolean_to_string('isIntroCta'),
        'recruitmentQuestionType',
        boolean_to_string('shouldUseAdvancedTargeting'),
        boolean_to_string('hasAssignableTurfs'),
        boolean_to_string('isBatchImportDone'),
        array_to_string('prioritizations'),
        boolean_to_string('isPersonal'),
        'activeUntilMts',
        'actionType',
        'instructionsHtml',
        'name',
        'conversationStarter',
        boolean_to_string('shouldDisplayElectionDayPollingLocation'),
        boolean_to_string('isGeocodingDone'),
        'advancedTargetingFilter',
    ]) }} as _airbyte_ctas_hashid,
    tmp.*
from {{ ref('ctas_ab2') }} as tmp
-- ctas
where 1 = 1
