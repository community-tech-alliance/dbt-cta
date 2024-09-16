{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('vendor_credits_Line_AccountBasedExpenseLineDetail_ab1') }}
select
    _airbyte_Line_hashid,
    cast(ClassRef as {{ type_json() }}) as ClassRef,
    cast(TaxCodeRef as {{ type_json() }}) as TaxCodeRef,
    cast(BillableStatus as {{ dbt_utils.type_string() }}) as BillableStatus,
    cast(AccountRef as {{ type_json() }}) as AccountRef,
    cast(CustomerRef as {{ type_json() }}) as CustomerRef,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('vendor_credits_Line_AccountBasedExpenseLineDetail_ab1') }}
-- AccountBasedExpenseLineDetail at vendor_credits/Line/AccountBasedExpenseLineDetail
where 1 = 1
