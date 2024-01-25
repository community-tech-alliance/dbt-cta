{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('taggings_ab4') }}
select
    context,
    tag_id,
    created_at,
    tagger_type,
    id,
    phone_banking_question_id,
    taggable_id,
    tagger_id,
    taggable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_taggings_hashid
from {{ ref('taggings_ab4') }}
-- taggings from {{ source('cta', '_airbyte_raw_taggings') }}
