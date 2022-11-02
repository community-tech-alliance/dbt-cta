{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('solution_articles_seo_data_ab1') }}
select
    _airbyte_solution_articles_hashid,
    cast(meta_title as {{ dbt_utils.type_string() }}) as meta_title,
    meta_keywords,
    cast(meta_description as {{ dbt_utils.type_string() }}) as meta_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('solution_articles_seo_data_ab1') }}
-- seo_data at solution_articles/seo_data
where 1 = 1

