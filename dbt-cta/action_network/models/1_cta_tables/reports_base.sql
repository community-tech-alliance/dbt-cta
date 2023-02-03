{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('reports_ab3') }}
select
    id,
    name,
    uuid,
    hidden,
    status,
    user_id,
    group_id,
    permalink,
    created_at,
    start_date,
    updated_at,
    csv_file_name,
    csv_file_size,
    next_run_date,
    report_format,
    csv_updated_at,
    first_permalink,
    csv_content_type,
    recurring_emails,
    recurring_interval,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_reports_hashid
from {{ ref('reports_ab3') }}
-- reports from {{ source('cta', '_airbyte_raw_reports') }}
where 1 = 1

