{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('documents_scd') }}
select
    tenant_id,
    updated_at,
    user_id,
    name,
    created_at,
    id,
    folder_id,
    file_data,
    file_locator,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_documents_hashid
from {{ ref('documents_scd') }}
-- documents from {{ source('sv_blocks', '_airbyte_raw_documents') }}

