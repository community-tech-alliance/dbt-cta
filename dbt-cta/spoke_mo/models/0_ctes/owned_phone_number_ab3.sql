{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('owned_phone_number_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'service',
        'allocated_to_id',
        'area_code',
        'service_id',
        'allocated_to',
        'organization_id',
        'created_at',
        'phone_number',
        'id',
        'allocated_at',
    ]) }} as _airbyte_owned_phone_number_hashid,
    tmp.*
from {{ ref('owned_phone_number_ab2') }} tmp
-- owned_phone_number
where 1 = 1


