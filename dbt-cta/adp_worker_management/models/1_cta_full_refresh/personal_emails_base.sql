{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_personal_emails_hashid'
) }}

-- Final base SQL model
-- depends_on: {{ ref('personal_emails_ab3') }}

select
    associateOID,
    nameCode_codeValue,
    nameCode_shortName,
    emailUri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_personal_emails_hashid
from {{ ref('personal_emails_ab3') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
