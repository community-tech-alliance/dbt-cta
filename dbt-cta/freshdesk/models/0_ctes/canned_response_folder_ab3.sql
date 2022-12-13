{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('canned_response_folder_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        boolean_to_string('personal'),
        'created_at',
        'updated_at',
        'responses_count',
    ]) }} as _airbyte_canned_response_folders_hashid,
    tmp.*
from {{ ref('canned_response_folder_ab2') }} tmp
-- canned_response_folders
where 1 = 1

