{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_files_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'name',
        adapter.quote('order'),
        'user_id',
        'group_id',
        'file_type',
        'mime_type',
        'parent_id',
        'permalink',
        'created_at',
        'updated_at',
        'description',
        'download_number',
        'user_file_file_name',
        'user_file_file_size',
        'user_file_content_type',
    ]) }} as _airbyte_user_files_hashid,
    tmp.*
from {{ ref('user_files_ab2') }} as tmp
-- user_files
where 1 = 1
