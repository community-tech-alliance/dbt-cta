select * from {{ source('cta', 'active_storage_blobs_base') }}
