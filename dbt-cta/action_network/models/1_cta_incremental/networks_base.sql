{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('networks_ab4') }}
select
    id,
    name,
    terms,
    created_at,
    updated_at,
    sms_enabled,
    ip_pool_name,
    csv_file_name,
    csv_file_size,
    csv_updated_at,
    csv_content_type,
    lock_custom_fields,
    top_level_group_id,
    opted_in_mobile_number,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_networks_hashid
from {{ ref('networks_ab4') }}
