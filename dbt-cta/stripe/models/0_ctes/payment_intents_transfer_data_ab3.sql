{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_transfer_data_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_payment_intents_hashid',
        'amount',
        'destination',
    ]) }} as _airbyte_transfer_data_hashid,
    tmp.*
from {{ ref('payment_intents_transfer_data_ab2') }} as tmp
-- transfer_data at payment_intents_base/transfer_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

