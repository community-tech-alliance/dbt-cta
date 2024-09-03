select
    _airbyte_emitted_at,
    uri,
    hold,
    label,
    muted,
    status,
    call_sid,
    coaching,
    account_sid,
    date_created,
    date_updated,
    conference_sid,
    call_sid_to_coach,
    end_conference_on_exit,
    start_conference_on_enter
from {{ source('cta','conference_participants_base') }}
