{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payments_card_details_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payments_hashid',
        object_to_string('card'),
        'status',
        'avs_status',
        'cvv_status',
        'entry_method',
        object_to_string('card_payment_timeline'),
        'statement_description',
    ]) }} as _airbyte_card_details_hashid,
    tmp.*
from {{ ref('payments_card_details_ab2') }} as tmp
-- card_details at payments/card_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

