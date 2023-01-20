{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_ab3') }}
select
    id,
    name,
    status,
    created_at,
    updated_at,
    interact_id,
    created_by_id,
    target_number,
    default_country,
    show_custom_ids,
    support_user_id,
    toplines_settings,
    default_entity_type_id,
    show_electoral_districts,
    allow_organizers_to_export,
    restricted_exporting_settings,
    activity_stream_as_initial_entity_view,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaigns_hashid
from {{ ref('campaigns_ab3') }}
-- campaigns from {{ source('cta', '_airbyte_raw_campaigns') }}
where 1 = 1

