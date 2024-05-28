{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('rsvps_ab4') }}
select
    id,
    city,
    uuid,
    email,
    phone,
    street,
    country,
    user_id,
    event_id,
    tag_list,
    zip_code,
    last_name,
    created_at,
    first_name,
    updated_at,
    guest_count,
    display_name,
    custom_fields,
    message_to_target,
    originating_system,
    updates_from_creator,
    updates_from_sponsor,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_rsvps_hashid
from {{ ref('rsvps_ab4') }}