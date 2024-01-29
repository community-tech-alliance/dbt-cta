{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('mobile_message_fields_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'text',
        'title',
        'created_at',
        'field_type',
        'updated_at',
        'mobile_message_id',
    ]) }} as _airbyte_mobile_message_fields_hashid,
    tmp.*
from {{ ref('mobile_message_fields_ab2') }} as tmp
-- mobile_message_fields
where 1 = 1
