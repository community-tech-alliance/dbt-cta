{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('letter_templates_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_letter_templates_hashid
from {{ ref('letter_templates_ab4') }}
