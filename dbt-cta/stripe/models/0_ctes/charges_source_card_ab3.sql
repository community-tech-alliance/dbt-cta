{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_source_card_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_source_hashid',
        'name',
        'type',
        'brand',
        'last4',
        'country',
        'funding',
        'exp_year',
        'cvc_check',
        'exp_month',
        'fingerprint',
        'dynamic_last4',
        'three_d_secure',
        'address_zip_check',
        'address_line1_check',
        'tokenization_method',
    ]) }} as _airbyte_card_hashid,
    tmp.*
from {{ ref('charges_source_card_ab2') }} tmp
-- card at charges_base/source/card
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

