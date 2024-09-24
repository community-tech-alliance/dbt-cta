{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pending_message_part_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'service',
        'parent_id',
        'service_id',
        'service_message',
        'created_at',
        'id',
        'contact_number',
        'user_number',
    ]) }} as _airbyte_pending_message_part_hashid,
    tmp.*
from {{ ref('pending_message_part_ab2') }} as tmp
-- pending_message_part
where 1 = 1
