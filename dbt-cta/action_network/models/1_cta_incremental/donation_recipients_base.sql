{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('donation_recipients_ab4') }}
select
    id,
    user_id,
    group_id,
    created_at,
    updated_at,
    fundraising_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_donation_recipients_hashid
from {{ ref('donation_recipients_ab4') }}
