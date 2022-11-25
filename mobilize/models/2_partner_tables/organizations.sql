{{
    config(
        cluster_by="_airbyte_emitted_at",
        partition_by={
            "field": "_airbyte_emitted_at",
            "data_type": "timestamp",
            "granularity": "day",
        },
        unique_key="_airbyte_organizations_hashid",
    )
}}

-- depends_on: {{ source('cta', 'organizations_base') }}
select
    _airbyte_organizations_hashid,
    max(id) as id,
    max(name) as name,
    max(slug) as slug,
    max(committee_id) as committee_id,
    max(_airbyte_ab_id) as _airbyte_ab_id,
    max(_airbyte_emitted_at) as _airbyte_emitted_at
from {{ source("cta", "organizations_base") }}
group by _airbyte_organizations_hashid
