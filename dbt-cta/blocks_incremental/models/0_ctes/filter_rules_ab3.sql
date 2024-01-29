{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('filter_rules_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'updated_at',
        'param',
        'column',
        'created_at',
        'filter_view_id',
        'id',
        'operator',
    ]) }} as _airbyte_filter_rules_hashid,
    tmp.*
from {{ ref('filter_rules_ab2') }} as tmp
-- filter_rules
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

