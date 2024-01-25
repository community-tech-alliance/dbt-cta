{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('petition_packets_ab3') }}
select
    filename,
    updated_at,
    shift_id,
    county,
    created_at,
    id,
    assignee_id,
    file_locator,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    _airbyte_normalized_at,
    _airbyte_petition_packets_hashid
from {{ ref('petition_packets_ab3') }}
