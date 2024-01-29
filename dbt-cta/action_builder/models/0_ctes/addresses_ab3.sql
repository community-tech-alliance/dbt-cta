{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('addresses_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'city',
        'dw_id',
        'state',
        'source',
        'status',
        'country',
        'accuracy',
        'latitude',
        'owner_id',
        'timezone',
        'longitude',
        'complement',
        'created_at',
        'owner_type',
        'updated_at',
        boolean_to_string('geocode_bad'),
        'interact_id',
        'postal_code',
        'accuracy_type',
        'created_by_id',
        'updated_by_id',
        'geocode_source',
        'street_address',
    ]) }} as _airbyte_addresses_hashid,
    tmp.*
from {{ ref('addresses_ab2') }} as tmp
-- addresses
where 1 = 1
