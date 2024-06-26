{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('donations_ab4') }}
select
    id,
    city,
    uuid,
    email,
    phone,
    state,
    amount,
    address,
    country,
    user_id,
    tag_list,
    zip_code,
    last_name,
    recurring,
    created_at,
    first_name,
    updated_at,
    display_name,
    total_amount,
    custom_amount,
    custom_fields,
    salesforce_id,
    fundraising_id,
    recurring_period,
    message_to_target,
    originating_system,
    updates_from_creator,
    updates_from_sponsor,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_donations_hashid
from {{ ref('donations_ab4') }}
