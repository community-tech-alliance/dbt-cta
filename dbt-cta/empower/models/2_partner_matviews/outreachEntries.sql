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
from {{ ref('outreachEntries_base') }}