{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('campaigns_scd') }}
select
    _airbyte_campaigns_hashid,
    {{ json_extract_scalar('social_card', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('social_card', ['image_url'], ['image_url']) }} as image_url,
    {{ json_extract_scalar('social_card', ['description'], ['description']) }} as description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_scd') }} as table_alias
-- social_card at campaigns/social_card
where 1 = 1
and social_card is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

