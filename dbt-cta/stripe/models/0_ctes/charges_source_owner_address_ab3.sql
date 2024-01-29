{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_source_owner_address_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_owner_hashid',
        'city',
        'line1',
        'line2',
        'state',
        'country',
        'postal_code',
    ]) }} as _airbyte_address_hashid,
    tmp.*
from {{ ref('charges_source_owner_address_ab2') }} as tmp
-- address at charges_base/source/owner/address
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

