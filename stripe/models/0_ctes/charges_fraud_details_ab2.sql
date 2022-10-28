{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_fraud_details_ab1') }}
select
    _airbyte_charges_hashid,
    cast(stripe_report as {{ dbt_utils.type_string() }}) as stripe_report,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_fraud_details_ab1') }}
-- fraud_details at charges/fraud_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

