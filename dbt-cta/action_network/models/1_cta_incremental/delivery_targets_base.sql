{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('delivery_targets_ab4') }}
select
    id,
    uuid,
    bioid,
    email,
    status,
    message,
    subject,
    form_data,
    created_at,
    updated_at,
    captcha_uid,
    captcha_url,
    delivery_id,
    target_name,
    target_party,
    target_state,
    delivery_method,
    target_district,
    target_position,
    captcha_required,
    letter_template_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_delivery_targets_hashid
from {{ ref('delivery_targets_ab4') }}
