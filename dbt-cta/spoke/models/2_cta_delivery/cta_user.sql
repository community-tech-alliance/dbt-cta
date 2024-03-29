
SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    assigned_cell,
    auth0_id,
    cell,
    created_at,
    email,
    first_name,
    id,
    is_superadmin,
    is_suspended,
    last_name,
    notification_frequency,
    terms,
    updated_at,
    _cta_hashid
FROM {{ source('cta', 'user_base') }}