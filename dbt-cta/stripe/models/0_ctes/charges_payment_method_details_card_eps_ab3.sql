{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_payment_method_details_card_eps_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_card_hashid',
        'verified_name',
    ]) }} as _airbyte_eps_hashid,
    tmp.*
from {{ ref('charges_payment_method_details_card_eps_ab2') }} as tmp
-- eps at charges_base/payment_method_details/card/eps
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

