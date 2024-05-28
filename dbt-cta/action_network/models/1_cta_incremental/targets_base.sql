{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('targets_ab4') }}
select
    id,
    title,
    failure,
    user_id,
    group_id,
    shapefile,
    created_at,
    updated_at,
    fail_message,
    csv_file_name,
    csv_file_size,
    network_share,
    csv_content_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_targets_hashid
from {{ ref('targets_ab4') }}