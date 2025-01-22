{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('credit_memos_Line_ab1') }}
select
    _airbyte_credit_memos_hashid,
    cast(LineNum as {{ dbt_utils.type_bigint() }}) as LineNum,
    cast(Description as {{ dbt_utils.type_string() }}) as Description,
    cast(DetailType as {{ dbt_utils.type_string() }}) as DetailType,
    cast(Amount as {{ dbt_utils.type_float() }}) as Amount,
    cast(SalesItemLineDetail as {{ type_json() }}) as SalesItemLineDetail,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('credit_memos_Line_ab1') }}
-- Line at credit_memos/Line
where 1 = 1
