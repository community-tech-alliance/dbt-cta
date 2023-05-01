select
    outreachCurrentCtaId,
    outreachEngagementLevel,
    outreachCreatedMts,
    outreachCtaProgress,
    outreachSnoozeType,
    outreachNote,
    outreachScheduledFollowUpMts,
    organizerEid,
    outreachDidGetResponse,
    outreachSnoozeUntilMts,
    targetEid,
    outreachContactMode,
    _airbyte_outreachEntries_hashid
from {{ source('cta','outreachEntries_base') }}