{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('adaccounts_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(timezone as {{ dbt_utils.type_string() }}) as timezone,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(regulations as {{ type_json() }}) as regulations,
    cast(billing_type as {{ dbt_utils.type_string() }}) as billing_type,
    cast(organization_id as {{ dbt_utils.type_string() }}) as organization_id,
    cast(billing_center_id as {{ dbt_utils.type_string() }}) as billing_center_id,
    funding_source_ids,
    {{ cast_to_boolean('client_paying_invoices') }} as client_paying_invoices,
    cast(advertiser_organization_id as {{ dbt_utils.type_string() }}) as advertiser_organization_id,
    {{ cast_to_boolean('agency_representing_client') }} as agency_representing_client,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('adaccounts_ab1') }}
-- adaccounts
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

