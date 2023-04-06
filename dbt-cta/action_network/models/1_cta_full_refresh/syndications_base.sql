{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('syndications_ab3') }}
select
    id,
    uuid,
    stats,
    title,
    hidden,
    status,
    user_id,
    email_id,
    group_id,
    action_id,
    permalink,
    created_at,
    updated_at,
    action_type,
    description,
    first_publish,
    salesforce_id,
    display_creator,
    first_permalink,
    photo_file_name,
    photo_file_size,
    originating_system,
    photo_content_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_syndications_hashid
from {{ ref('syndications_ab3') }}
-- syndications from {{ source('cta', '_airbyte_raw_syndications') }}
where 1 = 1

