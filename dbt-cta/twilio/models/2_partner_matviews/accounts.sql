select
    _airbyte_emitted_at,
    sid,
    uri,
    type,
    status,
    auth_token,
    date_created,
    date_updated,
    friendly_name,
    subresource_uris,
    owner_account_sid,
from {{ source('cta','accounts_base') }}