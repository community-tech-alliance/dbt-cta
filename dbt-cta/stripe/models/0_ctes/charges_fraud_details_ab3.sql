{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_fraud_details_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_charges_hashid',
        'stripe_report',
    ]) }} as _airbyte_fraud_details_hashid,
    tmp.*
from {{ ref('charges_fraud_details_ab2') }} tmp
-- fraud_details at charges_base/fraud_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

