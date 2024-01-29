{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payments_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'note',
        'status',
        'order_id',
        'created_at',
        array_to_string('refund_ids'),
        'updated_at',
        'employee_id',
        'location_id',
        'receipt_url',
        'source_type',
        object_to_string('total_money'),
        object_to_string('amount_money'),
        object_to_string('card_details'),
        'delay_action',
        'delayed_until',
        'version_token',
        object_to_string('approved_money'),
        'delay_duration',
        array_to_string('processing_fee'),
        'receipt_number',
        object_to_string('refunded_money'),
        object_to_string('risk_evaluation'),
    ]) }} as _airbyte_payments_hashid,
    tmp.*
from {{ ref('payments_ab2') }} as tmp
-- payments
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

