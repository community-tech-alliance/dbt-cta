{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('metrics_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'updated_at',
        'name',
        'metric_type',
        'created_at',
        'id',
        'label',
        boolean_to_string('show_on_leaderboard'),
        boolean_to_string('required'),
    ]) }} as _airbyte_metrics_hashid,
    tmp.*
from {{ ref('metrics_ab2') }} tmp
-- metrics
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

