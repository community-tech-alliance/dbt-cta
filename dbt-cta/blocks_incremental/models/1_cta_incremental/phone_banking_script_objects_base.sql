{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('phone_banking_script_objects_ab3') }}
select
    is_section_divider,
    scriptable_id,
    updated_at,
    created_at,
    scriptable_type,
    script_id,
    id,
    question_id,
    position_in_script,
    script_text_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_phone_banking_script_objects_hashid
from {{ ref('phone_banking_script_objects_ab3') }}
-- phone_banking_script_objects from {{ source('cta', '_airbyte_raw_phone_banking_script_objects') }}

