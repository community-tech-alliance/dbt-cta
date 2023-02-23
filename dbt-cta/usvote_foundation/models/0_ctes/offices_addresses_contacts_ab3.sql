{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_usvote_foundation",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('offices_addresses_contacts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_addresses_hashid',
        'id',
        'address_uri',
        'official_uri',
    ]) }} as _airbyte_contacts_hashid,
    tmp.*
from {{ ref('offices_addresses_contacts_ab2') }} tmp
-- contacts at offices/addresses/contacts
where 1 = 1

