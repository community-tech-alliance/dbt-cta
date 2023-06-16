{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('searches_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'updated_at',
        'query',
        'search_params',
        'name',
        'extras',
        'created_at',
        'id',
        'created_by_user_id',
        array_to_string('current_list'),
    ]) }} as _airbyte_searches_hashid,
    tmp.*
from {{ ref('searches_ab2') }} tmp
-- searches
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

