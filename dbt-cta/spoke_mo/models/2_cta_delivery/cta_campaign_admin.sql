select
    ingest_method,
    ingest_data_reference,
    deleted_optouts_count,
    updated_at,
    ingest_success,
    created_at,
    id,
    ingest_result,
    duplicate_contacts_count,
    contacts_count,
    campaign_id,
    _airbyte_extracted_at,
    _airbyte_campaign_admin_hashid
from {{ source('cta','campaign_admin_base') }}