{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "freshdesk_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('solution_articles_ab3') }}
select
    id,
    hits,
    tags,
    title,
    status,
    agent_id,
    seo_data,
    folder_id,
    thumbs_up,
    created_at,
    updated_at,
    category_id,
    description,
    thumbs_down,
    description_text,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_solution_articles_hashid
from {{ ref('solution_articles_ab3') }}
-- solution_articles from {{ source('freshdesk_partner_a', '_airbyte_raw_solution_articles') }}
where 1 = 1

