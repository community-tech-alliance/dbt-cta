{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('core_fields_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'city',
        'phone',
        'state',
        'street',
        'country',
        'user_id',
        'language',
        'latitude',
        'owner_id',
        'zip_code',
        'last_name',
        'longitude',
        'created_at',
        'first_name',
        'owner_type',
        'updated_at',
    ]) }} as _airbyte_core_fields_hashid,
    tmp.*
from {{ ref('core_fields_ab2') }} as tmp
-- core_fields
where 1 = 1
