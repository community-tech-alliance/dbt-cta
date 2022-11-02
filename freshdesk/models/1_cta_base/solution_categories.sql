{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "freshdesk_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('solution_categories_ab3') }}
select
    id,
    name,
    created_at,
    updated_at,
    description,
    visible_in_portals,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_solution_categories_hashid
from {{ ref('solution_categories_ab3') }}
-- solution_categories from {{ source('freshdesk_partner_a', '_airbyte_raw_solution_categories') }}
where 1 = 1

