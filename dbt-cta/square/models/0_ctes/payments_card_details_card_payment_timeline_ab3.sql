{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payments_card_details_card_payment_timeline_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_card_details_hashid',
        'voided_at',
        'captured_at',
        'authorized_at',
    ]) }} as _airbyte_card_payment_timeline_hashid,
    tmp.*
from {{ ref('payments_card_details_card_payment_timeline_ab2') }} as tmp
-- card_payment_timeline at payments/card_details/card_payment_timeline
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

