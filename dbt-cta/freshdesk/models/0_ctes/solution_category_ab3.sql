{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('solution_category_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'name',
        'created_at',
        'updated_at',
        'description',
        array_to_string('visible_in_portals'),
    ]) }} as _airbyte_solution_categories_hashid,
    tmp.*
from {{ ref('solution_category_ab2') }} tmp
-- solution_categories
where 1 = 1

