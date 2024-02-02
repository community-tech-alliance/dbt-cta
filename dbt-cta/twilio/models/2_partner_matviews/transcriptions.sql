select
    _airbyte_emitted_at,
    sid,
    uri,
    type,
    price,
    status,
    duration,
    price_unit,
    account_sid,
    api_version,
    date_created,
    date_updated,
    recording_sid,
    transcription_text
from {{ source('cta','transcriptions_base') }}
