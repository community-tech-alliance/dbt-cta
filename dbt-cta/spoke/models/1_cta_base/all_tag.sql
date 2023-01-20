{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('all_tag_ab3') }}
select
    id,
    title,
    author_id,
    is_system,
    created_at,
    deleted_at,
    text_color,
    updated_at,
    description,
    webhook_url,
    is_assignable,
    on_apply_script,
    organization_id,
    background_color,
    confirmation_steps,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_all_tag_hashid
from {{ ref('all_tag_ab3') }}
-- all_tag from {{ source('public', '_airbyte_raw_all_tag') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

