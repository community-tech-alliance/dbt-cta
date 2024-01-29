{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_tenders_card_details_card_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_card_details_hashid',
        'last_4',
        'card_brand',
        'fingerprint',
    ]) }} as _airbyte_card_hashid,
    tmp.*
from {{ ref('orders_tenders_card_details_card_ab2') }} as tmp
-- card at orders/tenders/card_details/card
where 1 = 1
