{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}

-- depends_on: {{ ref('ads_ab3') }}
select
    id,
    name,
    type,
    status,
    created_at,
    updated_at,
    ad_squad_id,
    creative_id,
    render_type,
    review_status,
    delivery_status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ads_hashid
from {{ ref('ads_ab3') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

