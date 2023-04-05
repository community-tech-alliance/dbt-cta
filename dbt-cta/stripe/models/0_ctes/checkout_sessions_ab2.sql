{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(mode as {{ dbt_utils.type_string() }}) as mode,
    cast(locale as {{ dbt_utils.type_string() }}) as locale,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(consent as {{ type_json() }}) as consent,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(customer as {{ dbt_utils.type_string() }}) as customer,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(shipping as {{ type_json() }}) as shipping,
    cast(cancel_url as {{ dbt_utils.type_string() }}) as cancel_url,
    cast(expires_at as {{ dbt_utils.type_bigint() }}) as expires_at,
    cast(submit_type as {{ dbt_utils.type_string() }}) as submit_type,
    cast(success_url as {{ dbt_utils.type_string() }}) as success_url,
    cast(amount_total as {{ dbt_utils.type_bigint() }}) as amount_total,
    cast(setup_intent as {{ dbt_utils.type_string() }}) as setup_intent,
    cast(subscription as {{ dbt_utils.type_string() }}) as subscription,
    cast(automatic_tax as {{ type_json() }}) as automatic_tax,
    cast(total_details as {{ type_json() }}) as total_details,
    cast(customer_email as {{ dbt_utils.type_string() }}) as customer_email,
    cast(payment_intent as {{ dbt_utils.type_string() }}) as payment_intent,
    cast(payment_status as {{ dbt_utils.type_string() }}) as payment_status,
    cast(recovered_from as {{ dbt_utils.type_string() }}) as recovered_from,
    cast(amount_subtotal as {{ dbt_utils.type_bigint() }}) as amount_subtotal,
    cast(after_expiration as {{ type_json() }}) as after_expiration,
    cast(customer_details as {{ type_json() }}) as customer_details,
    cast(tax_id_collection as {{ type_json() }}) as tax_id_collection,
    cast(consent_collection as {{ type_json() }}) as consent_collection,
    cast(client_reference_id as {{ dbt_utils.type_string() }}) as client_reference_id,
    payment_method_types,
    {{ cast_to_boolean('allow_promotion_codes') }} as allow_promotion_codes,
    cast(payment_method_options as {{ type_json() }}) as payment_method_options,
    cast(phone_number_collection as {{ type_json() }}) as phone_number_collection,
    cast(billing_address_collection as {{ dbt_utils.type_string() }}) as billing_address_collection,
    cast(shipping_address_collection as {{ type_json() }}) as shipping_address_collection,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_ab1') }}
-- checkout_sessions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

