{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_payment_method_details_ab1') }}
select
    _airbyte_charges_hashid,
    cast(card as {{ type_json() }}) as card,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(alipay as {{ type_json() }}) as alipay,
    cast(ach_debit as {{ type_json() }}) as ach_debit,
    cast(bancontact as {{ type_json() }}) as bancontact,
    cast(ach_credit_transfer as {{ type_json() }}) as ach_credit_transfer,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_ab1') }}
-- payment_method_details at charges_base/payment_method_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

