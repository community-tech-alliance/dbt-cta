{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'engagements') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    uid,
    type,
    active,
    source,
    teamId,
    ownerId,
    metadata,
    portalId,
    sourceId,
    createdAt,
    createdBy,
    timestamp,
    modifiedBy,
    ownerIdsCc,
    ownerIdsTo,
    attachments,
    bodyPreview,
    gdprDeleted,
    lastUpdated,
    metadata_cc,
    metadata_to,
    ownerIdsBcc,
    activityType,
    associations,
    metadata_bcc,
    ownerIdsFrom,
    metadata_body,
    metadata_from,
    metadata_html,
    metadata_text,
    metadata_title,
    scheduledTasks,
    bodyPreviewHtml,
    metadata_sender,
    metadata_source,
    metadata_status,
    metadata_endTime,
    metadata_iCalUid,
    metadata_sentVia,
    metadata_subject,
    metadata_isAllDay,
    metadata_location,
    metadata_priority,
    metadata_sourceId,
    metadata_taskType,
    metadata_threadId,
    metadata_timezone,
    metadata_toNumber,
    validationSkipped,
    metadata_messageId,
    metadata_reminders,
    metadata_startTime,
    queueMembershipIds,
    metadata_externalId,
    metadata_fromNumber,
    metadata_loggedFrom,
    metadata_ownerIdsCc,
    metadata_ownerIdsTo,
    metadata_trackerKey,
    allAccessibleTeamIds,
    associations_dealIds,
    metadata_disposition,
    metadata_externalUrl,
    metadata_guestEmails,
    metadata_ownerIdsBcc,
    associations_ownerIds,
    associations_quoteIds,
    metadata_errorMessage,
    metadata_locationType,
    metadata_ownerIdsFrom,
    metadata_recordingUrl,
    pendingInlineImageIds,
    associations_ticketIds,
    bodyPreviewIsTruncated,
    metadata_forObjectType,
    associations_companyIds,
    associations_contactIds,
    associations_contentIds,
    metadata_calleeObjectId,
    metadata_completionDate,
    metadata_meetingOutcome,
    metadata_postSendStatus,
    associations_workflowIds,
    metadata_facsimileSendId,
    metadata_meetingChangeId,
    metadata_attendeeOwnerIds,
    metadata_calleeObjectType,
    metadata_emailSendEventId,
    metadata_bounceErrorDetail,
    metadata_calendarEventHash,
    metadata_createdFromLinkId,
    metadata_externalAccountId,
    metadata_sequenceStepOrder,
    metadata_validationSkipped,
    metadata_attachedVideoOpened,
    metadata_sendDefaultReminder,
    metadata_attachedVideoWatched,
    metadata_durationMilliseconds,
    metadata_internalMeetingNotes,
    metadata_recipientDropReasons,
    associations_marketingEventIds,
    metadata_mediaProcessingStatus,
    metadata_pendingInlineImageIds,
    metadata_unknownVisitorConversation,
    metadata_preMeetingProspectReminders,
    metadata_includeDescriptionInReminder,
   {{ dbt_utils.surrogate_key([
     'id',
    'uid',
    'type',
    'active',
    'source',
    'teamId',
    'ownerId',
    'portalId',
    'sourceId',
    'createdAt',
    'createdBy',
    'timestamp',
    'modifiedBy',
    'bodyPreview',
    'gdprDeleted',
    'lastUpdated',
    'activityType',
    'metadata_body',
    'metadata_html',
    'metadata_text',
    'metadata_title',
    'bodyPreviewHtml',
    'metadata_source',
    'metadata_status',
    'metadata_endTime',
    'metadata_iCalUid',
    'metadata_sentVia',
    'metadata_subject',
    'metadata_isAllDay',
    'metadata_location',
    'metadata_priority',
    'metadata_sourceId',
    'metadata_taskType',
    'metadata_threadId',
    'metadata_timezone',
    'metadata_toNumber',
    'metadata_messageId',
    'metadata_startTime',
    'metadata_externalId',
    'metadata_fromNumber',
    'metadata_loggedFrom',
    'metadata_trackerKey',
    'metadata_disposition',
    'metadata_externalUrl',
    'metadata_errorMessage',
    'metadata_locationType',
    'metadata_recordingUrl',
    'bodyPreviewIsTruncated',
    'metadata_forObjectType',
    'metadata_calleeObjectId',
    'metadata_completionDate',
    'metadata_meetingOutcome',
    'metadata_postSendStatus',
    'metadata_facsimileSendId',
    'metadata_meetingChangeId',
    'metadata_calleeObjectType',
    'metadata_calendarEventHash',
    'metadata_createdFromLinkId',
    'metadata_externalAccountId',
    'metadata_sequenceStepOrder',
    'metadata_attachedVideoOpened',
    'metadata_sendDefaultReminder',
    'metadata_attachedVideoWatched',
    'metadata_durationMilliseconds',
    'metadata_internalMeetingNotes',
    'metadata_recipientDropReasons',
    'metadata_mediaProcessingStatus',
    'metadata_unknownVisitorConversation',
    'metadata_includeDescriptionInReminder'
    ]) }} as _airbyte_engagements_hashid
from {{ source('cta', 'engagements') }}
