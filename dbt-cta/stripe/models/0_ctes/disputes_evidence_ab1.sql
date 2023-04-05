{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('disputes_base') }}
select
    _airbyte_disputes_hashid,
    {{ json_extract_scalar('evidence', ['receipt'], ['receipt']) }} as receipt,
    {{ json_extract_scalar('evidence', ['service_date'], ['service_date']) }} as service_date,
    {{ json_extract_scalar('evidence', ['customer_name'], ['customer_name']) }} as customer_name,
    {{ json_extract_scalar('evidence', ['refund_policy'], ['refund_policy']) }} as refund_policy,
    {{ json_extract_scalar('evidence', ['shipping_date'], ['shipping_date']) }} as shipping_date,
    {{ json_extract_scalar('evidence', ['billing_address'], ['billing_address']) }} as billing_address,
    {{ json_extract_scalar('evidence', ['shipping_address'], ['shipping_address']) }} as shipping_address,
    {{ json_extract_scalar('evidence', ['shipping_carrier'], ['shipping_carrier']) }} as shipping_carrier,
    {{ json_extract_scalar('evidence', ['customer_signature'], ['customer_signature']) }} as customer_signature,
    {{ json_extract_scalar('evidence', ['uncategorized_file'], ['uncategorized_file']) }} as uncategorized_file,
    {{ json_extract_scalar('evidence', ['uncategorized_text'], ['uncategorized_text']) }} as uncategorized_text,
    {{ json_extract_scalar('evidence', ['access_activity_log'], ['access_activity_log']) }} as access_activity_log,
    {{ json_extract_scalar('evidence', ['cancellation_policy'], ['cancellation_policy']) }} as cancellation_policy,
    {{ json_extract_scalar('evidence', ['duplicate_charge_id'], ['duplicate_charge_id']) }} as duplicate_charge_id,
    {{ json_extract_scalar('evidence', ['product_description'], ['product_description']) }} as product_description,
    {{ json_extract_scalar('evidence', ['customer_purchase_ip'], ['customer_purchase_ip']) }} as customer_purchase_ip,
    {{ json_extract_scalar('evidence', ['cancellation_rebuttal'], ['cancellation_rebuttal']) }} as cancellation_rebuttal,
    {{ json_extract_scalar('evidence', ['service_documentation'], ['service_documentation']) }} as service_documentation,
    {{ json_extract_scalar('evidence', ['customer_communication'], ['customer_communication']) }} as customer_communication,
    {{ json_extract_scalar('evidence', ['customer_email_address'], ['customer_email_address']) }} as customer_email_address,
    {{ json_extract_scalar('evidence', ['shipping_documentation'], ['shipping_documentation']) }} as shipping_documentation,
    {{ json_extract_scalar('evidence', ['refund_policy_disclosure'], ['refund_policy_disclosure']) }} as refund_policy_disclosure,
    {{ json_extract_scalar('evidence', ['shipping_tracking_number'], ['shipping_tracking_number']) }} as shipping_tracking_number,
    {{ json_extract_scalar('evidence', ['refund_refusal_explanation'], ['refund_refusal_explanation']) }} as refund_refusal_explanation,
    {{ json_extract_scalar('evidence', ['duplicate_charge_explanation'], ['duplicate_charge_explanation']) }} as duplicate_charge_explanation,
    {{ json_extract_scalar('evidence', ['cancellation_policy_disclosure'], ['cancellation_policy_disclosure']) }} as cancellation_policy_disclosure,
    {{ json_extract_scalar('evidence', ['duplicate_charge_documentation'], ['duplicate_charge_documentation']) }} as duplicate_charge_documentation,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('disputes_base') }} as table_alias
-- evidence at disputes_base/evidence
where 1 = 1
and evidence is not null
{{ incremental_clause('_airbyte_emitted_at') }}

