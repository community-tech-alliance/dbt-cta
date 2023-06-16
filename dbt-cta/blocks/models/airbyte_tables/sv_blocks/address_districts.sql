{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',

    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='deliveries_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('address_districts_ab3') }}
select
    address_id,
    district_id,
    district_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_address_districts_hashid
from {{ ref('address_districts_ab3') }}
-- address_districts from {{ source('sv_blocks', '_airbyte_raw_address_districts') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

