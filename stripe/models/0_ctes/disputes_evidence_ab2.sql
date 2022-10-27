{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('disputes_evidence_ab1') }}
select
    _airbyte_disputes_hashid,
    cast(receipt as {{ dbt_utils.type_string() }}) as receipt,
    cast(service_date as {{ dbt_utils.type_string() }}) as service_date,
    cast(customer_name as {{ dbt_utils.type_string() }}) as customer_name,
    cast(refund_policy as {{ dbt_utils.type_string() }}) as refund_policy,
    cast(shipping_date as {{ dbt_utils.type_string() }}) as shipping_date,
    cast(billing_address as {{ dbt_utils.type_string() }}) as billing_address,
    cast(shipping_address as {{ dbt_utils.type_string() }}) as shipping_address,
    cast(shipping_carrier as {{ dbt_utils.type_string() }}) as shipping_carrier,
    cast(customer_signature as {{ dbt_utils.type_string() }}) as customer_signature,
    cast(uncategorized_file as {{ dbt_utils.type_string() }}) as uncategorized_file,
    cast(uncategorized_text as {{ dbt_utils.type_string() }}) as uncategorized_text,
    cast(access_activity_log as {{ dbt_utils.type_string() }}) as access_activity_log,
    cast(cancellation_policy as {{ dbt_utils.type_string() }}) as cancellation_policy,
    cast(duplicate_charge_id as {{ dbt_utils.type_string() }}) as duplicate_charge_id,
    cast(product_description as {{ dbt_utils.type_string() }}) as product_description,
    cast(customer_purchase_ip as {{ dbt_utils.type_string() }}) as customer_purchase_ip,
    cast(cancellation_rebuttal as {{ dbt_utils.type_string() }}) as cancellation_rebuttal,
    cast(service_documentation as {{ dbt_utils.type_string() }}) as service_documentation,
    cast(customer_communication as {{ dbt_utils.type_string() }}) as customer_communication,
    cast(customer_email_address as {{ dbt_utils.type_string() }}) as customer_email_address,
    cast(shipping_documentation as {{ dbt_utils.type_string() }}) as shipping_documentation,
    cast(refund_policy_disclosure as {{ dbt_utils.type_string() }}) as refund_policy_disclosure,
    cast(shipping_tracking_number as {{ dbt_utils.type_string() }}) as shipping_tracking_number,
    cast(refund_refusal_explanation as {{ dbt_utils.type_string() }}) as refund_refusal_explanation,
    cast(duplicate_charge_explanation as {{ dbt_utils.type_string() }}) as duplicate_charge_explanation,
    cast(cancellation_policy_disclosure as {{ dbt_utils.type_string() }}) as cancellation_policy_disclosure,
    cast(duplicate_charge_documentation as {{ dbt_utils.type_string() }}) as duplicate_charge_documentation,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('disputes_evidence_ab1') }}
-- evidence at disputes/evidence
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

