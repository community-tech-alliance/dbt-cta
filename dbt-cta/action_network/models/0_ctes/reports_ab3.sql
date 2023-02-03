{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('reports_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'uuid',
        'hidden',
        'status',
        'user_id',
        'group_id',
        'permalink',
        'created_at',
        'start_date',
        'updated_at',
        'csv_file_name',
        'csv_file_size',
        'next_run_date',
        'report_format',
        'csv_updated_at',
        'first_permalink',
        'csv_content_type',
        'recurring_emails',
        'recurring_interval',
    ]) }} as _airbyte_reports_hashid,
    tmp.*
from {{ ref('reports_ab2') }} tmp
-- reports
where 1 = 1

