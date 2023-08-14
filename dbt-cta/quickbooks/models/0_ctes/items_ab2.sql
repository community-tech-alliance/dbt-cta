{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('items_ab1') }}
select
    cast(Description as {{ dbt_utils.type_string() }}) as Description,
    cast(QtyOnHand as {{ dbt_utils.type_bigint() }}) as QtyOnHand,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(FullyQualifiedName as {{ dbt_utils.type_string() }}) as FullyQualifiedName,
    cast(PurchaseDesc as {{ dbt_utils.type_string() }}) as PurchaseDesc,
    {{ cast_to_boolean('TrackQtyOnHand') }} as TrackQtyOnHand,
    cast(AssetAccountRef as {{ type_json() }}) as AssetAccountRef,
    cast(IncomeAccountRef as {{ type_json() }}) as IncomeAccountRef,
    cast(Name as {{ dbt_utils.type_string() }}) as Name,
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    cast(Type as {{ dbt_utils.type_string() }}) as Type,
    {{ cast_to_boolean('Active') }} as Active,
    cast(UnitPrice as {{ dbt_utils.type_float() }}) as UnitPrice,
    cast(ExpenseAccountRef as {{ type_json() }}) as ExpenseAccountRef,
    {{ cast_to_boolean('sparse') }} as sparse,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(PurchaseCost as {{ dbt_utils.type_float() }}) as PurchaseCost,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast({{ empty_string_to_null('InvStartDate') }} as {{ type_date() }}) as InvStartDate,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    {{ cast_to_boolean('Taxable') }} as Taxable,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('items_ab1') }}
-- items
where 1 = 1

