{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('log_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'from_num',
        'to_num',
        'created_at',
        'error_code',
        'id',
        'body',
        'message_sid',
    ]) }} as _airbyte_log_hashid,
    tmp.*
from {{ ref('log_ab2') }} as tmp
-- log
where 1 = 1
