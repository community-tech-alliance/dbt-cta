{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_contact_address_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_page_hashid',
        'country',
        'city',
        'street1',
        'id',
        'street2',
        'region',
        'postal_code',
    ]) }} as _airbyte_contact_address_hashid,
    tmp.*
from {{ ref('page_contact_address_ab2') }} tmp
-- contact_address at page/contact_address
where 1 = 1

