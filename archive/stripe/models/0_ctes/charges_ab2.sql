{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(card as {{ type_json() }}) as card,
    {{ cast_to_boolean('paid') }} as paid,
    cast({{ adapter.quote('order') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('order') }},
    cast(amount as {{ dbt_utils.type_bigint() }}) as amount,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(review as {{ dbt_utils.type_string() }}) as review,
    cast(source as {{ type_json() }}) as source,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(dispute as {{ dbt_utils.type_string() }}) as dispute,
    cast(invoice as {{ dbt_utils.type_string() }}) as invoice,
    cast(outcome as {{ type_json() }}) as outcome,
    cast(refunds as {{ type_json() }}) as refunds,
    {{ cast_to_boolean('captured') }} as captured,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(customer as {{ dbt_utils.type_string() }}) as customer,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    {{ cast_to_boolean('refunded') }} as refunded,
    cast(shipping as {{ type_json() }}) as shipping,
    cast(application as {{ dbt_utils.type_string() }}) as application,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(destination as {{ dbt_utils.type_string() }}) as destination,
    cast(failure_code as {{ dbt_utils.type_string() }}) as failure_code,
    cast(on_behalf_of as {{ dbt_utils.type_string() }}) as on_behalf_of,
    cast(fraud_details as {{ type_json() }}) as fraud_details,
    cast(receipt_email as {{ dbt_utils.type_string() }}) as receipt_email,
    cast(payment_intent as {{ dbt_utils.type_string() }}) as payment_intent,
    cast(receipt_number as {{ dbt_utils.type_string() }}) as receipt_number,
    cast(transfer_group as {{ dbt_utils.type_string() }}) as transfer_group,
    cast(amount_refunded as {{ dbt_utils.type_bigint() }}) as amount_refunded,
    cast(application_fee as {{ dbt_utils.type_string() }}) as application_fee,
    cast(failure_message as {{ dbt_utils.type_string() }}) as failure_message,
    cast(source_transfer as {{ dbt_utils.type_string() }}) as source_transfer,
    cast(balance_transaction as {{ dbt_utils.type_string() }}) as balance_transaction,
    cast(statement_descriptor as {{ dbt_utils.type_string() }}) as statement_descriptor,
    cast(statement_description as {{ dbt_utils.type_string() }}) as statement_description,
    cast(payment_method_details as {{ type_json() }}) as payment_method_details,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_ab1') }}
-- charges
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

