{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('activism_options_configs_ab4') }}
select
    skills,
    campaigns,
    languages,
    turf_id,
    id,
    issues,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_activism_options_configs_hashid
from {{ ref('activism_options_configs_ab4') }}
-- activism_options_configs from {{ source('cta', '_airbyte_raw_activism_options_configs') }}
