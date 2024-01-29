{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('dashboard_layouts_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'updated_at',
        'name',
        'created_at',
        'id',
        'created_by_user_id',
        'content',
    ]) }} as _airbyte_dashboard_layouts_hashid,
    tmp.*
from {{ ref('dashboard_layouts_ab2') }} tmp
-- dashboard_layouts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

