{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('filter_views_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'metadata',
        'conjunction',
        'updated_at',
        'user_id',
        'name',
        'created_at',
        'rules',
        'id',
    ]) }} as _airbyte_filter_views_hashid,
    tmp.*
from {{ ref('filter_views_ab2') }} tmp
-- filter_views
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

