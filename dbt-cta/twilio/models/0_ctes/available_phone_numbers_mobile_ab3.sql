{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('available_phone_numbers_mobile_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        boolean_to_string('beta'),
        'lata',
        'region',
        'latitude',
        'locality',
        'longitude',
        'iso_country',
        'postal_code',
        'rate_center',
        object_to_string('capabilities'),
        'phone_number',
        'friendly_name',
        'address_requirements',
    ]) }} as _airbyte_available_phone_numbers_mobile_hashid,
    tmp.*
from {{ ref('available_phone_numbers_mobile_ab2') }} as tmp
-- available_phone_numbers_mobile
where 1 = 1
