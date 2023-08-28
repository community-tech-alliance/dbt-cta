{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_refunds_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_charges_hashid',
        'url',
        array_to_string('data'),
        'object',
        boolean_to_string('has_more'),
        'total_count',
    ]) }} as _airbyte_refunds_hashid,
    tmp.*
from {{ ref('charges_refunds_ab2') }} as tmp
-- refunds at charges_base/refunds
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

