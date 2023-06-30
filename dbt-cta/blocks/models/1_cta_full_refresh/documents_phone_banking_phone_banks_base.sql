{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('documents_phone_banking_phone_banks_ab3') }}
select
    phone_bank_id,
    updated_at,
    created_at,
    document_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    _airbyte_normalized_at,
    _airbyte_documents_phone_banking_phone_banks_hashid
from {{ ref('documents_phone_banking_phone_banks_ab3') }}
-- documents_phone_banking_phone_banks from {{ source('cta', '_airbyte_raw_documents_phone_banking_phone_banks') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

