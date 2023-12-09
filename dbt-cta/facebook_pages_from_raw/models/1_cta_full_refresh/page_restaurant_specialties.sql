{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='page_restaurant_specialties_scd'
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
-- depends_on: {{ ref('page_restaurant_specialties_ab3') }}
select
    _airbyte_page_hashid,
    lunch,
    coffee,
    drinks,
    breakfast,
    dinner,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_restaurant_specialties_hashid
from {{ ref('page_restaurant_specialties_ab3') }}
-- restaurant_specialties at page/restaurant_specialties from {{ ref('page') }}
where 1 = 1

