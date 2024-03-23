{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_tickets_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(amount as {{ dbt_utils.type_float() }}) as amount,
    cast(quantity as {{ dbt_utils.type_bigint() }}) as quantity,
    cast(ticket_id as {{ dbt_utils.type_bigint() }}) as ticket_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(ticket_price as {{ dbt_utils.type_float() }}) as ticket_price,
    cast(ticket_receipt_id as {{ dbt_utils.type_bigint() }}) as ticket_receipt_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_tickets_ab1') }}
-- user_tickets
where 1 = 1
