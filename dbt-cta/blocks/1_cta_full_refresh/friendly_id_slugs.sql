{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "sv_blocks",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='friendly_id_slugs_scd'
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
) }}
-- Final base SQL model
-- depends_on: {{ ref('friendly_id_slugs_ab3') }}
select
    sluggable_type,
    scope,
    sluggable_id,
    created_at,
    id,
    slug,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_friendly_id_slugs_hashid
from {{ ref('friendly_id_slugs_ab3') }}
-- friendly_id_slugs from {{ source('sv_blocks', '_airbyte_raw_friendly_id_slugs') }}
where 1 = 1

