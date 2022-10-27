{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(amount as {{ dbt_utils.type_bigint() }}) as amount,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(review as {{ dbt_utils.type_string() }}) as review,
    cast(source as {{ dbt_utils.type_string() }}) as source,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(charges as {{ type_json() }}) as charges,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(invoice as {{ dbt_utils.type_string() }}) as invoice,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(customer as {{ dbt_utils.type_string() }}) as customer,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(shipping as {{ type_json() }}) as shipping,
    cast(application as {{ dbt_utils.type_string() }}) as application,
    cast(canceled_at as {{ dbt_utils.type_bigint() }}) as canceled_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(next_action as {{ type_json() }}) as next_action,
    cast(on_behalf_of as {{ dbt_utils.type_string() }}) as on_behalf_of,
    cast(client_secret as {{ dbt_utils.type_string() }}) as client_secret,
    cast(receipt_email as {{ dbt_utils.type_string() }}) as receipt_email,
    cast(transfer_data as {{ type_json() }}) as transfer_data,
    cast(capture_method as {{ dbt_utils.type_string() }}) as capture_method,
    cast(payment_method as {{ dbt_utils.type_string() }}) as payment_method,
    cast(transfer_group as {{ dbt_utils.type_string() }}) as transfer_group,
    cast(amount_received as {{ dbt_utils.type_bigint() }}) as amount_received,
    cast(amount_capturable as {{ dbt_utils.type_bigint() }}) as amount_capturable,
    cast(last_payment_error as {{ type_json() }}) as last_payment_error,
    cast(setup_future_usage as {{ dbt_utils.type_string() }}) as setup_future_usage,
    cast(cancellation_reason as {{ dbt_utils.type_string() }}) as cancellation_reason,
    cast(confirmation_method as {{ dbt_utils.type_string() }}) as confirmation_method,
    payment_method_types,
    cast(statement_description as {{ dbt_utils.type_string() }}) as statement_description,
    cast(application_fee_amount as {{ dbt_utils.type_bigint() }}) as application_fee_amount,
    cast(payment_method_options as {{ type_json() }}) as payment_method_options,
    cast(statement_descriptor_suffix as {{ dbt_utils.type_string() }}) as statement_descriptor_suffix,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_ab1') }}
-- payment_intents
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

