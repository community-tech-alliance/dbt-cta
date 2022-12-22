{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('categories_category_data_ab3') }}
select
    _airbyte_categories_hashid,
    name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_category_data_hashid
from {{ ref('categories_category_data_ab3') }}
-- category_data at categories/category_data from {{ ref('categories') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

