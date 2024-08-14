{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('customers_ab3') }}
select
    id,
    cards,
    address,
    version,
    birthday,
    group_ids,
    created_at,
    given_name,
    updated_at,
    family_name,
    preferences,
    segment_ids,
    company_name,
    phone_number,
    reference_id,
    email_address,
    creation_source,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_customers_hashid
from {{ ref('customers_ab3') }}
-- customers from {{ source('cta', '_airbyte_raw_customers') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

