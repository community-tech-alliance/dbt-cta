{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payments_processing_fee_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payments_hashid',
        'type',
        object_to_string('amount_money'),
        'effective_at',
    ]) }} as _airbyte_processing_fee_hashid,
    tmp.*
from {{ ref('payments_processing_fee_ab2') }} as tmp
-- processing_fee at payments/processing_fee
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

