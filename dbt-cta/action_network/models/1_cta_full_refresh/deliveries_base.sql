{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('deliveries_ab3') }}
select
    id,
    city,
    uuid,
    email,
    phone,
    state,
    status,
    street,
    country,
    user_id,
    tag_list,
    zip_code,
    form_data,
    last_name,
    letter_id,
    created_at,
    first_name,
    updated_at,
    display_name,
    custom_fields,
    message_to_target,
    originating_system,
    updates_from_creator,
    updates_from_sponsor,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_deliveries_hashid
from {{ ref('deliveries_ab3') }}
-- deliveries from {{ source('cta', '_airbyte_raw_deliveries') }}
where 1 = 1

