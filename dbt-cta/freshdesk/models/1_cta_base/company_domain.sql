{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
) }}
-- Final base SQL model
-- depends_on: {{ ref('companies_ab3') }}
select
    id as company_id,
    domain,
    _airbyte_ab_id,
    _airbyte_emitted_at,
from {{ ref('companies_ab3') }} companies, UNNEST(companies.domains) as domain
-- companies from {{ source('cta', '_airbyte_raw_companies') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

