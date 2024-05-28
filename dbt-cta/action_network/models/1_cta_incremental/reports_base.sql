{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('reports_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_reports_hashid
from {{ ref('reports_ab4') }}