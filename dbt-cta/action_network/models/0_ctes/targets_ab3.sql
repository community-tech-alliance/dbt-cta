{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('targets_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'title',
        'failure',
        'user_id',
        'group_id',
        'shapefile',
        'created_at',
        'updated_at',
        'fail_message',
        'csv_file_name',
        'csv_file_size',
        'network_share',
        'csv_content_type',
    ]) }} as _airbyte_targets_hashid,
    tmp.*
from {{ ref('targets_ab2') }} as tmp
-- targets
where 1 = 1
