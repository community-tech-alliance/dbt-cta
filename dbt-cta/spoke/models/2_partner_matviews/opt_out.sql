SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    assignment_id,
    cell,
    created_at,
    id,
    organization_id,
    reason_code,
    updated_at,
    _unique_row_id
FROM {{ source('cta', 'opt_out_base') }}
                        