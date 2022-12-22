{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('refunds_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'reason',
        'status',
        'order_id',
        'created_at',
        'payment_id',
        'updated_at',
        'location_id',
        object_to_string('amount_money'),
        array_to_string('processing_fee'),
    ]) }} as _airbyte_refunds_hashid,
    tmp.*
from {{ ref('refunds_ab2') }} tmp
-- refunds
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

