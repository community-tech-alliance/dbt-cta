{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_merge_logs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'list_id',
        'list_type',
        'created_at',
        'updated_at',
        'merged_user_id',
        'removed_user_id',
        'merged_user_email',
        'removed_user_email',
    ]) }} as _airbyte_user_merge_logs_hashid,
    tmp.*
from {{ ref('user_merge_logs_ab2') }} as tmp
-- user_merge_logs
where 1 = 1
