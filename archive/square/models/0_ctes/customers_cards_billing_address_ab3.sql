{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_cards_billing_address_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_cards_hashid',
        'postal_code',
    ]) }} as _airbyte_billing_address_hashid,
    tmp.*
from {{ ref('customers_cards_billing_address_ab2') }} as tmp
-- billing_address at customers/cards/billing_address
where 1 = 1
