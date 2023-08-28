{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('offices_addresses_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_offices_hashid',
        'id',
        'zip',
        'city',
        'zip4',
        'state',
        'street1',
        'street2',
        'website',
        array_to_string('contacts'),
        array_to_string('functions'),
        'address_to',
        'main_email',
        'is_physical',
        'resource_uri',
        'is_regular_mail',
        'main_fax_number',
        'main_phone_number',
        'primary_contact_uri',
    ]) }} as _airbyte_addresses_hashid,
    tmp.*
from {{ ref('offices_addresses_ab2') }} as tmp
-- addresses at offices/addresses
where 1 = 1
