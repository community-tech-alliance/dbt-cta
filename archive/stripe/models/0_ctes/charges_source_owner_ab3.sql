{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_source_owner_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_source_hashid',
        'name',
        'email',
        'phone',
        object_to_string('address'),
        'verified_name',
        'verified_email',
        'verified_phone',
        'verified_address',
    ]) }} as _airbyte_owner_hashid,
    tmp.*
from {{ ref('charges_source_owner_ab2') }} as tmp
-- owner at charges_base/source/owner
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

