{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('entities_ab3') }}
select
    id,
    age,
    dw_id,
    nickname,
    custom_id,
    last_name,
    created_at,
    first_name,
    updated_at,
    custom_id_1,
    custom_id_2,
    custom_id_3,
    custom_id_4,
    interact_id,
    middle_name,
    voterbase_id,
    created_by_id,
    date_of_birth,
    updated_by_id,
    entity_type_id,
    linked_user_id,
    organization_id,
    preferred_language,
    calculated_birth_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_entities_hashid
from {{ ref('entities_ab3') }}
-- entities from {{ source('cta', '_airbyte_raw_entities') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
