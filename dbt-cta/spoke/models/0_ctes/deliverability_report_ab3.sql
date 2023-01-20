{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('deliverability_report_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'domain',
        'url_path',
        'count_sent',
        'computed_at',
        'count_error',
        'count_total',
        'period_ends_at',
        'count_delivered',
        'period_starts_at',
    ]) }} as _airbyte_deliverability_report_hashid,
    tmp.*
from {{ ref('deliverability_report_ab2') }} tmp
-- deliverability_report
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

