{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_work_assignments_assigned_organizational_units_hashid'
) }}

-- Final base SQL model
-- depends_on: {{ ref('work_assignments_assigned_organizational_units_ab3') }}

SELECT
    associateOID,
    itemID,
    nameCode_codeValue,
    nameCode_shortName,
    typeCode_codeValue,
    typeCode_shortName,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_work_assignments_assigned_organizational_units_hashid
from {{ ref('work_assignments_assigned_organizational_units_ab3') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

