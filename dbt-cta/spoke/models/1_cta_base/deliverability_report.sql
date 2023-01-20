{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('deliverability_report_ab3') }}
select
    id,
    domain,
    url_path,
    count_sent,
    computed_at,
    count_error,
    count_total,
    period_ends_at,
    count_delivered,
    period_starts_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_deliverability_report_hashid
from {{ ref('deliverability_report_ab3') }}
-- deliverability_report from {{ source('public', '_airbyte_raw_deliverability_report') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

