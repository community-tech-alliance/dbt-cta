{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_ab4') }}
select
    id,
    uuid,
    title,
    hidden,
    status,
    user_id,
    group_id,
    language,
    permalink,
    created_at,
    updated_at,
    first_publish,
    first_permalink,
    photo_file_name,
    photo_file_size,
    description_text,
    image_attribution,
    photo_content_type,
    administrative_title,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaigns_hashid
from {{ ref('campaigns_ab4') }}
