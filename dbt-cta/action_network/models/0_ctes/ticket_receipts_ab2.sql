{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ticket_receipts_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(amount as {{ dbt_utils.type_float() }}) as amount,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(is_comp as {{ dbt_utils.type_bigint() }}) as is_comp,
    cast(is_free as {{ dbt_utils.type_bigint() }}) as is_free,
    cast(payer_id as {{ dbt_utils.type_bigint() }}) as payer_id,
    cast(tag_list as {{ dbt_utils.type_string() }}) as tag_list,
    cast(zip_code as {{ dbt_utils.type_string() }}) as zip_code,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(tip_amount as {{ dbt_utils.type_bigint() }}) as tip_amount,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(checkout_id as {{ dbt_utils.type_bigint() }}) as checkout_id,
    cast(custom_amount as {{ dbt_utils.type_float() }}) as custom_amount,
    cast(custom_fields as {{ dbt_utils.type_string() }}) as custom_fields,
    cast(checkout_status as {{ dbt_utils.type_string() }}) as checkout_status,
    cast(stripe_charge_id as {{ dbt_utils.type_string() }}) as stripe_charge_id,
    cast(wepay_account_id as {{ dbt_utils.type_bigint() }}) as wepay_account_id,
    cast(stripe_account_id as {{ dbt_utils.type_bigint() }}) as stripe_account_id,
    cast(ticketed_event_id as {{ dbt_utils.type_bigint() }}) as ticketed_event_id,
    cast(originating_system as {{ dbt_utils.type_string() }}) as originating_system,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ticket_receipts_ab1') }}
-- ticket_receipts
where 1 = 1
