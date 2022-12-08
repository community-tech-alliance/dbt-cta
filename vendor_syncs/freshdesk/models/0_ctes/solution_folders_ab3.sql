{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('solution_folders_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'created_at',
        'updated_at',
        'visibility',
        array_to_string('company_ids'),
        'description',
        array_to_string('company_segment_ids'),
        array_to_string('contact_segment_ids'),
    ]) }} as _airbyte_solution_folders_hashid,
    tmp.*
from {{ ref('solution_folders_ab2') }} tmp
-- solution_folders
where 1 = 1

