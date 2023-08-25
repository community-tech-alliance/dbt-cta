{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payments_card_details_card_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_card_details_hashid',
        'bin',
        'last_4',
        'exp_year',
        'card_type',
        'exp_month',
        'card_brand',
        'fingerprint',
        'prepaid_type',
    ]) }} as _airbyte_card_hashid,
    tmp.*
from {{ ref('payments_card_details_card_ab2') }} as tmp
-- card at payments/card_details/card
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

