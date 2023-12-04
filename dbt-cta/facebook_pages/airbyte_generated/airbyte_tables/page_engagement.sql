{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "default",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='page_engagement_scd'
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
-- depends_on: {{ ref('page_engagement_ab3') }}
select
    _airbyte_page_hashid,
    social_sentence_without_like,
    count_string,
    social_sentence_with_like,
    count_string_without_like,
    count,
    count_string_with_like,
    social_sentence,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_engagement_hashid
from {{ ref('page_engagement_ab3') }}
-- engagement at page/engagement from {{ ref('page') }}
where 1 = 1

