{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "freshdesk_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('solution_articles_seo_data_ab3') }}
select
    _airbyte_solution_articles_hashid,
    meta_title,
    meta_keywords,
    meta_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_seo_data_hashid
from {{ ref('solution_articles_seo_data_ab3') }}
-- seo_data at solution_articles/seo_data from {{ ref('solution_articles') }}
where 1 = 1

