{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('event_documents_ab3') }}
select
    event_id,
    updated_at,
    created_at,
    id,
    folder_id,
    document_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_event_documents_hashid
from {{ ref('event_documents_ab3') }}
-- event_documents from {{ source('sv_blocks', '_airbyte_raw_event_documents') }}

