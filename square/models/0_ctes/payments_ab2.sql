{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payments_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(note as {{ dbt_utils.type_string() }}) as note,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(order_id as {{ dbt_utils.type_string() }}) as order_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    refund_ids,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(employee_id as {{ dbt_utils.type_string() }}) as employee_id,
    cast(location_id as {{ dbt_utils.type_string() }}) as location_id,
    cast(receipt_url as {{ dbt_utils.type_string() }}) as receipt_url,
    cast(source_type as {{ dbt_utils.type_string() }}) as source_type,
    cast(total_money as {{ type_json() }}) as total_money,
    cast(amount_money as {{ type_json() }}) as amount_money,
    cast(card_details as {{ type_json() }}) as card_details,
    cast(delay_action as {{ dbt_utils.type_string() }}) as delay_action,
    cast(delayed_until as {{ dbt_utils.type_string() }}) as delayed_until,
    cast(version_token as {{ dbt_utils.type_string() }}) as version_token,
    cast(approved_money as {{ type_json() }}) as approved_money,
    cast(delay_duration as {{ dbt_utils.type_string() }}) as delay_duration,
    processing_fee,
    cast(receipt_number as {{ dbt_utils.type_string() }}) as receipt_number,
    cast(refunded_money as {{ type_json() }}) as refunded_money,
    cast(risk_evaluation as {{ type_json() }}) as risk_evaluation,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payments_ab1') }}
-- payments
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

