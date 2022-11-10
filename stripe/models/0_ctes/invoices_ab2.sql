{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('invoices_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(tax as {{ dbt_utils.type_bigint() }}) as tax,
    {{ cast_to_boolean('paid') }} as paid,
    lines,
    cast(total as {{ dbt_utils.type_bigint() }}) as total,
    cast(charge as {{ dbt_utils.type_string() }}) as charge,
    {{ cast_to_boolean('closed') }} as closed,
    cast(number as {{ dbt_utils.type_string() }}) as number,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(billing as {{ dbt_utils.type_string() }}) as billing,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(payment as {{ dbt_utils.type_string() }}) as payment,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(customer as {{ dbt_utils.type_string() }}) as customer,
    cast(discount as {{ dbt_utils.type_string() }}) as discount,
    cast(due_date as {{ dbt_utils.type_float() }}) as due_date,
    {{ cast_to_boolean('forgiven') }} as forgiven,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(subtotal as {{ dbt_utils.type_bigint() }}) as subtotal,
    {{ cast_to_boolean('attempted') }} as attempted,
    discounts,
    cast(amount_due as {{ dbt_utils.type_bigint() }}) as amount_due,
    cast(period_end as {{ dbt_utils.type_float() }}) as period_end,
    cast(amount_paid as {{ dbt_utils.type_bigint() }}) as amount_paid,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(invoice_pdf as {{ dbt_utils.type_string() }}) as invoice_pdf,
    cast(tax_percent as {{ dbt_utils.type_float() }}) as tax_percent,
    {{ cast_to_boolean('auto_advance') }} as auto_advance,
    cast(period_start as {{ dbt_utils.type_float() }}) as period_start,
    cast(subscription as {{ dbt_utils.type_string() }}) as subscription,
    cast(attempt_count as {{ dbt_utils.type_bigint() }}) as attempt_count,
    cast(billing_reason as {{ dbt_utils.type_string() }}) as billing_reason,
    cast(ending_balance as {{ dbt_utils.type_bigint() }}) as ending_balance,
    cast(receipt_number as {{ dbt_utils.type_string() }}) as receipt_number,
    cast(application_fee as {{ dbt_utils.type_bigint() }}) as application_fee,
    cast(amount_remaining as {{ dbt_utils.type_bigint() }}) as amount_remaining,
    cast(starting_balance as {{ dbt_utils.type_bigint() }}) as starting_balance,
    cast(hosted_invoice_url as {{ dbt_utils.type_string() }}) as hosted_invoice_url,
    cast(next_payment_attempt as {{ dbt_utils.type_float() }}) as next_payment_attempt,
    cast(statement_descriptor as {{ dbt_utils.type_string() }}) as statement_descriptor,
    cast(statement_description as {{ dbt_utils.type_string() }}) as statement_description,
    cast(webhooks_delivered_at as {{ dbt_utils.type_float() }}) as webhooks_delivered_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invoices_ab1') }}
-- invoices
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

