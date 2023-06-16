{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='turfs_ab3'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "]
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('turfs_ab3') }}
select
    van_api_config,
    turf_level_id,
    qc_turnaround_days,
    default_phone_verification_script_id,
    extras,
    created_at,
    petition_requirements,
    min_phone_verification_rounds,
    archived,
    voter_registration_enabled,
    depth,
    updated_at,
    parent_id,
    qc_config,
    name,
    voter_registration_config,
    phone_verification_language,
    min_phone_verification_percent,
    id,
    lft,
    rgt,
    slug,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_turfs_hashid
from {{ ref('turfs_ab3') }}
-- turfs from {{ source('sv_blocks', '_airbyte_raw_turfs') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

