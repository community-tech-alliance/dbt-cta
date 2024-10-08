{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('reports_ab3') }}
select
    date,
    collection_id,
    updated_at,
    user_id,
    qualitative_metrics,
    quantitative_metrics,
    created_at,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_reports_hashid
from {{ ref('reports_ab3') }}
-- reports from {{ source('cta', '_airbyte_raw_reports') }}
