{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('deposits_Line_DepositLineDetail_ab1') }}
select
    _airbyte_Line_hashid,
    cast(PaymentMethodRef as {{ type_json() }}) as PaymentMethodRef,
    cast(AccountRef as {{ type_json() }}) as AccountRef,
    cast(CheckNum as {{ dbt_utils.type_string() }}) as CheckNum,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('deposits_Line_DepositLineDetail_ab1') }}
-- DepositLineDetail at deposits/Line/DepositLineDetail
where 1 = 1
