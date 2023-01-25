{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('letter_templates_ab3') }}
select
    id,
    tips,
    message,
    subject,
    targets,
    can_edit,
    editable,
    variants,
    letter_id,
    created_at,
    updated_at,
    image_attribution,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_letter_templates_hashid
from {{ ref('letter_templates_ab3') }}
-- letter_templates from {{ source('cta', '_airbyte_raw_letter_templates') }}
where 1 = 1

