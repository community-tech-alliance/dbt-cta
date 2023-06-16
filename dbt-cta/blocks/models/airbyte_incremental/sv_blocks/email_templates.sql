{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('email_templates_scd') }}
select
    _airbyte_unique_key,
    updated_at,
    template_content,
    name,
    extras,
    created_at,
    id,
    created_by_user_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_email_templates_hashid
from {{ ref('email_templates_scd') }}
-- email_templates from {{ source('sv_blocks', '_airbyte_raw_email_templates') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

