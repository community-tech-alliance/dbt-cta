{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- depends_on: {{ source('cta', 'responses') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    city,
    uuid,
    email,
    phone,
    status,
    street,
    country,
    timeout,
    user_id,
    finished,
    tag_list,
    zip_code,
    last_name,
    survey_id,
    created_at,
    first_name,
    updated_at,
    display_name,
    custom_fields,
    message_to_target,
    originating_system,
    subscription_params,
    updates_from_creator,
    updates_from_sponsor
from {{ source('cta', 'responses') }}
