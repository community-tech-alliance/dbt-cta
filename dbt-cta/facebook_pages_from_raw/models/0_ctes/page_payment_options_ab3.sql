{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_payment_options_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_page_hashid',
        'discover',
        'amex',
        'cash_only',
        'visa',
        'mastercard',
    ]) }} as _airbyte_payment_options_hashid,
    tmp.*
from {{ ref('page_payment_options_ab2') }} tmp
-- payment_options at page/payment_options
where 1 = 1

