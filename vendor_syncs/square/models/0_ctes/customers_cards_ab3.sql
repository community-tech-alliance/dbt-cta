{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_cards_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_customers_hashid',
        'id',
        'last_4',
        'exp_year',
        'exp_month',
        'card_brand',
        object_to_string('billing_address'),
        'cardholder_name',
    ]) }} as _airbyte_cards_hashid,
    tmp.*
from {{ ref('customers_cards_ab2') }} tmp
-- cards at customers/cards
where 1 = 1

