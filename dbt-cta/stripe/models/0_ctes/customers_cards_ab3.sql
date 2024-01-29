{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_cards_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_customers_hashid',
        'id',
        'name',
        'type',
        'brand',
        'last4',
        'object',
        'country',
        'funding',
        'customer',
        'exp_year',
        object_to_string('metadata'),
        'cvc_check',
        'exp_month',
        'address_zip',
        'fingerprint',
        'address_city',
        'address_line1',
        'address_line2',
        'address_state',
        'dynamic_last4',
        'address_country',
        'address_zip_check',
        'address_line1_check',
        'tokenization_method',
    ]) }} as _airbyte_cards_hashid,
    tmp.*
from {{ ref('customers_cards_ab2') }} as tmp
-- cards at customers_base/cards
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

