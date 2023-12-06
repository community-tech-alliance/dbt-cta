{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "default",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='page_voip_info_scd'
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
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('page_voip_info_ab3') }}
select
    _airbyte_page_hashid,
    reason_code,
    is_callable,
    has_permission,
    is_callable_webrtc,
    is_pushable,
    reason_description,
    has_mobile_app,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_voip_info_hashid
from {{ ref('page_voip_info_ab3') }}
-- voip_info at page/voip_info from {{ ref('page') }}
where 1 = 1

