{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('districts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'district_name',
        'updated_at',
        'extras',
        'created_at',
        'id',
        'state',
        'district_type',
        'district_type_id',
    ]) }} as _airbyte_districts_hashid,
    tmp.*
from {{ ref('districts_ab2') }} tmp
-- districts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

